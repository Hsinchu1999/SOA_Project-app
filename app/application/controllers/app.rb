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

    route do |routing|
      routing.public
      routing.assets

      routing.root do
        session[:testing] = 'home'
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
            puts "in mbti_test/submit_answer"
            puts "received routing params = #{routing.params}"
            unless routing.params.length == 1
              flash[:error] = 'Choose one discription that matches you'
              routing.redirect '/mbti_test/continue'
            end

            answer = routing.params.keys()[0]
            puts "answer=#{answer}"
            # puts "answer type=#{answer.class}"
            session[:mbti_answers][session[:answered_cnt]] = answer
            session[:answered_cnt] = session[:answered_cnt] + 1
            puts "session[:answered_cnt] = #{session[:answered_cnt]}"
            puts "session[:mbti_answers] = #{session[:mbti_answers]}"

            if session[:answered_cnt] == 4
              routing.redirect '/mbti_test/show_result'
            else
              routing.redirect '/mbti_test/continue'
            end
          end
        end
        routing.is 'show_result' do
          routing.get do
            # answer = routing.params['score']
            question_ids = session[:mbti_question_set]
            answers = session[:mbti_answers]
            result = Service::CalculateMBTIScore.new.call(
              question_ids: question_ids,
              answers: answers
            )

            if result.failure?
              puts "failed in show_result"
              routing.redirect '/'
            end

            session[:mbti_type] = result.value!.personalities

            routing.redirect '/mbti_test/result'
          end
        end
        routing.is 'previous_page' do
          routing.post do
            session[:answered_cnt] = session[:answered_cnt] - 1
            # session[:mbti_answers].pop
            if session[:answered_cnt].zero?
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
            # puts 'got result from Service::ListMBTIQuestionSet'
            # puts "result = #{result}"
            # puts "result value = #{result.value!}"
            # puts "result value type = #{result.value!.class}"
            # puts session[:mbti_question_set]

            if result.failure?
              # puts 'failed getting mbti question set, in /mbti_test/start'
              routing.redirect '/'
            else
              # puts 'success getting mbti question set, redirect to /mbti_test/continue'
              # puts "session[:mbti_question_set] = #{result.value!}"
              session[:mbti_question_set] = result.value!.question_set
              routing.redirect '/mbti_test/continue'
            end


            
          end
        end

        routing.is 'continue' do
          puts 'in mbti_test/continue'
          puts session[:answered_cnt]
          current_question_id = session[:mbti_question_set][session[:answered_cnt]]
          # puts "current_question_id = #{current_question_id}"
          # puts "current_question_id type = #{current_question_id.class}"
          # view 'mbti_test_general', locals: {current_question: session[:answered_cnt] + 1}
          result = Service::ListMBTIQuestion.new.call(current_question_id)

          if result.failure?
            puts 'failed in continue'
            routing.redirect '/'
          else
            # puts 'success'
            # puts "result.value! = #{result.value!}"
            # puts "result.value! type = #{result.value!.class}"
            puts result.value!.question
            puts result.value!.answerA

            viewable_mbti_question = Views::MBTIQuestion.new(result.value!)
            # puts "viewable_mbti_question = #{viewable_mbti_question}"

            view 'mbti_test_general', locals: {
              current_question: session[:answered_cnt] + 1,
              question: viewable_mbti_question }

          end
          # if session[:answered_cnt].nil?
          #   routing.redirect '/mbti_test/start'
          # else
          #   view 'mbti_test_general', locals: { current_question: session[:answered_cnt] + 1 }
          # end
        end

        routing.is 'last' do
          puts 'in mbti_test/last'
          puts session[:answered_cnt]
          if session[:answered_cnt] != 3
            routing.redirect '/mbti_test/start'
          else
            view 'mbti_test_last'
          end
        end

        routing.is 'result' do
          if session[:retry_username] == true
            # incomplete
            puts 'give some warning here by flash'
          end
          view 'mbti_test_result', locals: { mbti_type: session[:mbti_type] }
        end

        routing.is 'recommendation' do
          view 'recommendation'
        end
      end

      routing.on 'user' do
        routing.is do
          nickname = session[:current_user]
          puts 'currently at /user'
          puts ":current_user = #{nickname}"
          result = Service::ListUser.new.call(
            nickname: nickname
          )
          puts 'got result from Service::ListUser'
          puts "result = #{result}"
          puts "result value = #{result.value!}"

          if result.failure?
            routing.redirect '/user/login'
          else
            viewable_user = Views::User.new(JSON.parse(result.value!))
            view 'personal_page', locals: { user: viewable_user }
          end
        end

        routing.is 'construct_profile' do
          nickname = routing.params['nickname']
          mbti = routing.params['mbti']
          result = Service::AddUser.new.call(
            nickname: nickname,
            mbti:
          )

          if result.failure?
            puts 'in if'
            
            
          else
            puts 'in else'
          end
        end

        routing.is 'login' do
          nickname = session[:current_user]
          result = Service::ListUser.new.call(
            nickname: nickname
          )

          puts 'currently at user/login'
          puts 'user_name = '
          puts nickname
          if result.failure?
            puts 'not logged in'
            view 'login'
          else
            routing.redirect '/user'
          end
        end

        routing.is 'submit_login' do
          routing.post do
            nickname = routing.params['nickname']
            result = Service::ListUser.new.call(
              nickname: nickname
            )

            if result.failure?
              session[:retry_login] = true
              flash[:error] = 'Invalid Nickname'
              flash[:notice] = 'Type correct nickname or start journey to get recommendation'
              routing.redirect '/user/login'
            else
              puts 'in submit_login success-else'
              puts result.value!
              puts result.value!.class
              result_hash = JSON.parse(result.value!)
              puts result_hash['nickname']
              puts result_hash['id']
              puts result_hash['mbti']
              # puts user

              session[:current_user] = result_hash['nickname']
              routing.redirect '/user'
            end
          end
        end

        routing.is 'favorites' do
          nick_name = session[:current_user]
          user = Repository::Users.find_name(nick_name)
          if user
            viewable_user = Views::User.new(user)
            view 'favorites', locals: { favorite_attractions: viewable_user.favorite_attractions }
          else
            routing.redirect '/user/login'
          end
        end
        routing.is 'viewed-attraction' do
          view 'viewed_attraction'
        end
      end
    end
  end
end
