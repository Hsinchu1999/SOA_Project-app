# frozen_string_literal: true

require 'roda'
require 'yaml'
require 'sequel'
require 'figaro'

module TravellingSuggestions
  class App < Roda
    plugin :environments
      
    configure do
      Figaro.application = Figaro::Application.new(
        environment: environment,
        path: File.expand_path('config/secrets.yml')
      )
      Figaro.load
      def self.config() = Figaro.env
      
      configure :development, :test do
        ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
      end
      
      DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
      def self.DB = DB
    end
  end
end
