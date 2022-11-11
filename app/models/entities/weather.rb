# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'
require_relative 'forecast_one_week'
require_relative 'forecast_36hr'

module TravellingSuggestions
  module Entity
    class Weather < Dry::Struct
      include Dry.Types

      attribute :forecast_36hr,             Forecast_36Hr
      attribute :forecast_one_week,         Forecast_One_Week

    end
  end
end