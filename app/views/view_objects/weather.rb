# frozen_string_literal: true

require_relative 'forecast_36hr'
require_relative 'forecast_one_week'

module Views
  # A Views object for Entitiy::Weather
  class Weather
    def initialize(weather)
      @weather = weather
    end

    def forecast_36hr(index)
      # index: which 12 hrs (1 or 2 or 3)
      case index
      when 1
        Views::Forecast36Hr.new(@weather.forecast_36hr).first_12hr
      when 2
        Views::Forecast36Hr.new(@weather.forecast_36hr).second_12hr
      else
        Views::Forecast36Hr.new(@weather.forecast_36hr).third_12hr
      end
    end

    def forecast_one_week(index)
      # index: which day (1, 2, 3, 4, 5, 6, 7)
      case index
      when 1
        Views::ForecastOneWeek.new(@weather.forecast_one_week).day1
      when 2
        Views::ForecastOneWeek.new(@weather.forecast_one_week).day2
      when 3
        Views::ForecastOneWeek.new(@weather.forecast_one_week).day3
      when 4
        Views::ForecastOneWeek.new(@weather.forecast_one_week).day4
      when 5
        Views::ForecastOneWeek.new(@weather.forecast_one_week).day5
      when 6
        Views::ForecastOneWeek.new(@weather.forecast_one_week).day6
      else
        Views::ForecastOneWeek.new(@weather.forecast_one_week).day7
      end
    end
  end
end
