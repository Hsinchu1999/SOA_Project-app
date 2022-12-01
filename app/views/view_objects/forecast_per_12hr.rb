# frozen_string_literal: true

module Views
  # A Views object for Entity::ForecastPer12Hr
  class ForecastPer12Hr
    def initialize(forecast_per_12hr)
      @forecast_per_12hr = forecast_per_12hr
    end

    def view_all
      "rain: #{pop} % \nlowest temperature: #{min_temp} \nhighest temperature: #{max_temp}"
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
