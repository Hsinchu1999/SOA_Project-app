# frozen_string_literal: true

module TravellingSuggestions
  class Location
    def initialize(name, data)
      @name = name
      @location_data = parse_location(data)
    end
    def parse_location(data)
      data['records']['location'].select{|data| data['locationName'] == @name}[0]
    end
    def prob_rain
      @location_data['weatherElement'].select{|data| data['elementName'] == 'PoP'}[0]
    end
    def min_temperature
        @location_data['weatherElement'][0].select{|data| data['elementName'] == 'minT'}[0]
    end
    def max_temperature
        @location_data['weatherElement'][0].select{|data| data['elementName'] == 'maxT'}[0]
    end
  end
end