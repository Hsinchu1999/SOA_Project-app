require_relative 'weather'

module Views
  class Region
    def initialize(region)
      @region = region
    end

    def country
      @region.country
    end

    def city
      @region.city
    end

    def weather
      # returns a view object for Entity::Weather
      Views::Weather.new(region.weather)
    end
  end
end