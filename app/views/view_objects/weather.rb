require_relative 'forecast_36hr'
require_relative 'forecast_one_week'

module Views
  class Weather
    def initialize(weather)
      @weather = weather
    end

    def forecast_36hr(index)
      # index: which 12 hrs (1 or 2 or 3)
      if index == 1
        Views::Forecast_36Hr.new(@weather.forecast_36hr).first_12hr
      elsif index == 2
        Views::Forecast_36Hr.new(@weather.forecast_36hr).second_12hr
      else
        Views::Forecast_36Hr.new(@weather.forecast_36hr).third_12hr
      end
    end

    def forecast_one_week(index)
      # index: which day (1, 2, 3, 4, 5, 6, 7)
      if index == 1
        Views::Forecast_One_Week.new(@weather.forecast_one_week).day1
      elsif index == 2
        Views::Forecast_One_Week.new(@weather.forecast_one_week).day2
      elsif index == 3
        Views::Forecast_One_Week.new(@weather.forecast_one_week).day3
      elsif index == 4
        Views::Forecast_One_Week.new(@weather.forecast_one_week).day4
      elsif index == 5
        Views::Forecast_One_Week.new(@weather.forecast_one_week).day5
      elsif index == 6
        Views::Forecast_One_Week.new(@weather.forecast_one_week).day6
      else
        Views::Forecast_One_Week.new(@weather.forecast_one_week).day7
      end
    end
  end
end
