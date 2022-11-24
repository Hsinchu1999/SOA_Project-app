
module Views
  class Forecast_Per_Day
    def initialize(forecast_per_day)
      @forecast_per_day = forecast_per_day
    end

    def view_all
      "rain: #{pop} % \nlowest temperature: #{minT} \nhighest temperature: #{maxT}"
    end

    def pop
      @forecast_per_12hr.pop.to_s
    end

    def minT
      @forecast_per_12hr.minT.to_s
    end

    def maxT
      @forecast_per_12hr.maxT.to_s
    end

  end
end