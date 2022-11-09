require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class Forecast_One_Week < Dry::Struct
      include Dry.Types

      attribute :forecast_report_time,  Strict::String
      attribute :day1,                  Strict::Forecast_Per_Day
      attribute :day2,                  Strict::Forecast_Per_Day
      attribute :day3,                  Strict::Forecast_Per_Day
      attribute :day4,                  Strict::Forecast_Per_Day
      attribute :day5,                  Strict::Forecast_Per_Day
      attribute :day6,                  Strict::Forecast_Per_Day
      attribute :day7,                  Strict::Forecast_Per_Day

    end
  end
end