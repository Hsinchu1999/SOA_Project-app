# frozen_string_literal: true

require_relative 'forecast_per_day'

module Views
  # A Views object for Entity::ForecastOneWeek
  class ForecastOneWeek
    def initialize(forecast_one_week)
      @forecast_one_week = forecast_one_week
    end

    def forecast_report_time
      @forecast_one_week.forecast_report_time
    end

    def day1
      Views::ForecastPerDay.new(@forecast_one_week.day1).view_all
    end

    def day2
      Views::ForecastPerDay.new(@forecast_one_week.day2).view_all
    end

    def day3
      Views::ForecastPerDay.new(@forecast_one_week.day3).view_all
    end

    def day4
      Views::ForecastPerDay.new(@forecast_one_week.day4).view_all
    end

    def day5
      Views::ForecastPerDay.new(@forecast_one_week.day5).view_all
    end

    def day6
      Views::ForecastPerDay.new(@forecast_one_week.day6).view_all
    end

    def day7
      Views::ForecastPerDay.new(@forecast_one_week.day7).view_all
    end
  end
end
