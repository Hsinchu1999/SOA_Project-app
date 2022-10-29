# frozen_string_literal: true

require 'roda'
require 'slim'

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
    end

  end
end

