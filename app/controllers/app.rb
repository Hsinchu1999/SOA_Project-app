# frozen_string_literal: true

require 'roda'
require 'slim'

Slim::Engine.set_options encoding: "utf-8"

module TravellingSuggestions
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
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
            if location == 'hsinchu'
              location = '新竹縣'
            elsif location == 'taipei'
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
            answer = routing.params['score']
            # puts answer
            puts session[:answered_cnt]

            if session[:answered_cnt] >= 3
              routing.redirect '/mbti_test/last'
            else
              session[:answered_cnt] = session[:answered_cnt] + 1
              routing.redirect '/mbti_test/continue'
            end
          end
        end
        routing.is 'show_result' do
          routing.post do
            answer = routing.params['score']
            routing.redirect '/mbti_test/result'
          end
        end
        routing.is 'start' do
          session[:answered_cnt] = 0
          view 'mbti_test_first'
        end
        routing.is 'continue' do
          puts 'in mbti_test/continue'
          puts session[:answered_cnt]
          if session[:answered_cnt] == nil
            routing.redirect '/mbti_test/start'
          else
            view 'mbti_test_general'
          end
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
            puts "give some warning here by flash"
          end
          view 'mbti_test_result'
        end
        routing.is 'recommendation' do
          view 'recommendation'
        end
      end

      routing.on 'user' do
        routing.is 'construct_profile' do
          user_name = routing.params['user_name']
          puts "new user name is #{user_name}"
          if user_name == 'peterchen'
            # incomplete
            session[:retry_username] = true
            routing.redirect '/mbti_test/result'
          else
            # incomplete, write user profile into db
            session[:retry_username] = false
            session[:current_user] = user_name
            routing.redirect '/mbti_test/recommendation'
          end
        end
        routing.is do
          view 'personal_page'
        end
        routing.is 'favorites' do
          view 'favorites'
        end
        routing.is 'viewed-attraction' do
          view 'viewed_attraction'
        end
      end
    end

  end
end
