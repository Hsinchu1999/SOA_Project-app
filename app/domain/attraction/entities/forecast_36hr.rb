# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'
require_relative 'forecast_per_12hr'

module TravellingSuggestions
  module Entity
    # An Entity object for future 36 hr forecasts
    class Forecast36Hr < Dry::Struct
      include Dry.Types

      attribute :forecast_report_time,  Strict::String
      attribute :first_12hr,            ForecastPer12Hr
      attribute :second_12hr,           ForecastPer12Hr
      attribute :third_12hr,            ForecastPer12Hr
    end
  end
end
