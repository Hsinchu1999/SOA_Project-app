# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'
require 'json'

Slim::Engine.set_options encoding: 'utf-8'

module TravellingSuggestions
  # Web App
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views/views_html'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $Stderr
    plugin :public, root: 'app/views/public'
    plugin :flash
    plugin :halt
    plugin :caching

    route do |routing|
      routing.public
      routing.assets

      routing.root do
        response.expires 60, public: true
        view 'home'
      end

      routing.on 'weather' do
        routing.is do
          # POST /weather/
          routing.post do
            location = routing.params['location']
            routing.redirect "weather/#{location}"
          end
        end
        routing.on String do |location|
          routing.get do
            case location
            when 'hsinchu'
              location = '新竹縣'
            when 'taipei'
              location = '臺北市'
            end
            cwb_weather = TravellingSuggestions::CWB::LocationMapper
                          .new(CWB_TOKEN, TravellingSuggestions::CWB::CWBApi)
                          .find(location)
            view 'weather', locals: { weather: cwb_weather }
          end
        end
      end

      routing.on 'mbti_test' do
        routing.is 'submit_answer' do
          # accepts submitted mbti answers
          routing.post do
            unless routing.params.length == 1
              flash[:error] = 'Choose one discription that matches you'
              routing.redirect '/mbti_test/continue'
            end

            answer = routing.params.keys[0]
            session[:mbti_answers][session[:answered_cnt]] = answer
            session[:answered_cnt] = session[:answered_cnt] + 1

            if session[:answered_cnt] == 4
              routing.redirect '/mbti_test/show_result'
            else
              routing.redirect '/mbti_test/continue'
            end
          end
        end
        routing.is 'show_result' do
          routing.get do
            question_ids = session[:mbti_question_set]
            answers = session[:mbti_answers]
            result = Service::CalculateMBTIScore.new.call(
              question_ids:,
              answers:
            )

            routing.redirect '/' if result.failure?

            session[:mbti_type] = result.value!.personalities

            routing.redirect '/mbti_test/result'
          end
        end
        routing.is 'previous_page' do
          routing.post do
            session[:answered_cnt] = session[:answered_cnt] - 1
            if session[:answered_cnt] < 1
              routing.redirect '/mbti_test/start'
            else
              routing.redirect '/mbti_test/continue'
            end
          end
        end
        routing.is 'start' do
          if session[:current_user]
            routing.redirect '/user'
          else
            session[:answered_cnt] = 0
            session[:mbti_answers] = Array.new(4, '')

            result = Service::ListMBTIQuestionSet.new.call(1)

            if result.failure?
              routing.redirect '/'
            else
              session[:mbti_question_set] = result.value!.question_set
              routing.redirect '/mbti_test/continue'
            end
          end
        end

        routing.is 'continue' do
          current_question_id = session[:mbti_question_set][session[:answered_cnt]]
          result = Service::ListMBTIQuestion.new.call(current_question_id)

          if result.failure?
            routing.redirect '/'
          else

            viewable_mbti_question = Views::MBTIQuestion.new(result.value!)

            view 'mbti_test_general', locals: {
              current_question: session[:answered_cnt] + 1,
              question: viewable_mbti_question
            }

          end
        end

        routing.is 'last' do
          if session[:answered_cnt] != 3
            routing.redirect '/mbti_test/start'
          else
            view 'mbti_test_last'
          end
        end

        routing.is 'result' do
          if session[:retry_username] == true
            flash.now[:error] = 'Please choose another username'
            flash.now[:notice] = "User name has to be unique, and consists of a-Z + '_'"
          end
          view 'mbti_test_result', locals: { mbti_type: session[:mbti_type] }
        end
      end

      routing.on 'user' do
        routing.is do
          nickname = session[:current_user]
          result = Service::ListUser.new.call(
            nickname:
          )

          if result.failure?
            routing.redirect '/user/login'
          else
            viewable_user = Views::User.new(JSON.parse(result.value!))
            response.expires 60, public: true
            view 'personal_page', locals: { user: viewable_user }
          end
        end

        routing.is 'construct_profile' do
          nickname = routing.params['nickname']
          mbti_type = session[:mbti_type]
          result = Service::AddUser.new.call(
            nickname:,
            mbti_type:
          )

          if result.failure?
            session[:retry_username] = true
            routing.redirect '/mbti_test/result'

          else
            session[:current_user] = nickname
            routing.redirect '/user'
          end
        end

        routing.is 'login' do
          nickname = session[:current_user]
          result = Service::ListUser.new.call(
            nickname:
          )

          if result.failure?
            view 'login'
          else
            routing.redirect '/user'
          end
        end

        routing.is 'submit_login' do
          routing.post do
            nickname = routing.params['nickname']
            result = Service::ListUser.new.call(
              nickname:
            )

            if result.failure?
              session[:retry_login] = true
              flash[:error] = 'Invalid Nickname'
              flash[:notice] = 'Type correct nickname or start journey to get recommendation'
              routing.redirect '/user/login'
            else
              result_hash = JSON.parse(result.value!)
              session[:current_user] = result_hash['nickname']
              routing.redirect '/user'
            end
          end
        end

        routing.is 'favorites' do
          routing.redirect '/'
        end

        routing.on 'recommendation' do

          routing.is 'start' do
            session[:rc_answered_cnt] = 0
            session[:rc_answers] = Array.new(5, '')

            nickname = session[:current_user]
            result = Service::ListUser.new.call(
              nickname:
            )

            if result.failure?
              routing.redirect '/'
            end

            mbti = result.value!.mbti
            result = Service::ListAttractionSet.new.call(
              mbti: mbti, set_size: 5
            )

            if result.failure?
              routing.redirect '/'
            end

            session[:rc_qeustion_set] = result.value!.attraction_set
            routing.redirect '/user/recommendation/continue'
          end

          routing.is 'continue' do
            view 'recommendation'
          end

          routing.is 'submit' do
            routing.post do
              puts 'in /user/recommendation/submit'
              puts routing.params
              answer = routing.params['preference']
              session[:rc_answers][session[:rc_answered_cnt]] = answer
              session[:rc_answered_cnt] = session[:rc_answered_cnt] + 1

              if session[:rc_answered_cnt] == 5
                routing.redirect '/user/recommendation/result'
              else
                routing.redirect '/user/recommendation/continue'
              end
            end
          end

          routing.is 'result' do
            puts 'in /user/recommendation/result'
            puts session[:rc_answers]
            nickname = session[:current_user]
            attraction_ids = session[:rc_qeustion_set]
            answers = session[:rc_answers]
            result = Service::UpdateUserFavorite.new.call(
              nickname, attraction_ids, answers
            )

            routing.redirect '/' if result.failure?
            routing.redirect '/user'
          end
        end

        routing.is 'viewed-attraction' do
          view 'viewed_attraction'
        end
      end
    end
  end
end
