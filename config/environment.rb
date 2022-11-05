# frozen_string_literal: true

require 'roda'
require 'yaml'
require 'sequel'
require 'figaro'

module TravellingSuggestions
  class App < Roda
    plugin :environments
      
      Figaro.application = Figaro::Application.new(
        environment: environment,
        path: File.expand_path('config/secrets.yml')
      )
      Figaro.load
      ENV['DATABASE_URL'] = 'sqlite://#{config.DB_FILENAME}'

      def self.config() = Figaro.env
      #DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
      #def self.DB = DB
  end
end