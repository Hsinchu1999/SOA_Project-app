# frozen_string_literal: true

module TravellingSuggestions
  class Location
    def initialize(name, data)
      @name = name
      @location_data = parse_location(data)
    end
    def parse_location(data)
      data['records']['location'].select{|data| data['locationName'] == @name}
    end
    def prob_rain
      @location_data['weatherElement'].select{|data| data['elementName'] == 'PoP'}
    end
    def min_temperature
        @location_data['weatherElement'].select{|data| data['elementName'] == 'minT'}
    end
    def max_temperature
        @location_data['weatherElement'].select{|data| data['elementName'] == 'maxT'}
    end
  end
end