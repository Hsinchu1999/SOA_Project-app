# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'
require_relative 'forecast_per_day'

module TravellingSuggestions
  module Entity
    # An Entity object for future 1 week forecast
    class ForecastOneWeek < Dry::Struct
      include Dry.Types

      attribute :forecast_report_time,  Strict::String
      attribute :day1,                  Forecast_Per_Day
      attribute :day2,                  Forecast_Per_Day
      attribute :day3,                  Forecast_Per_Day
      attribute :day4,                  Forecast_Per_Day
      attribute :day5,                  Forecast_Per_Day
      attribute :day6,                  Forecast_Per_Day
      attribute :day7,                  Forecast_Per_Day
    end
  end
end
