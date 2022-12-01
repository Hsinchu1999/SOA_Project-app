# frozen_string_literal: true

module Views
  # A Views object for Entity::ForecastPerDay
  class ForecastPerDay
    def initialize(forecast_per_day)
      @forecast_per_day = forecast_per_day
    end

    def view_all
      "rain: #{pop} % \nlowest temperature: #{minT} \nhighest temperature: #{maxT}"
    end

    def pop
      @forecast_per_12hr.pop.to_s
    end

    def min_temp
      @forecast_per_12hr.min_temp.to_s
    end

    def max_temp
      @forecast_per_12hr.max_temp.to_s
    end
  end
end
