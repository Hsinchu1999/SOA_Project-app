# frozen_string_literal: true

require 'roda'
require 'slim'

Slim::Engine.set_options encoding: "utf-8"

module TravellingSuggestions
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $Stderr
    plugin :halt

    route do |routing|
      routing.assets

      routing.root do 
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
    end

  end
end
