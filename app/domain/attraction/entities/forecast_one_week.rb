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
      attribute :day1,                  ForecastPerDay
      attribute :day2,                  ForecastPerDay
      attribute :day3,                  ForecastPerDay
      attribute :day4,                  ForecastPerDay
      attribute :day5,                  ForecastPerDay
      attribute :day6,                  ForecastPerDay
      attribute :day7,                  ForecastPerDay
    end
  end
end
