# frozen_string_literal: true

module TravellingSuggestions
  class Location
    def initialize(data)
      @location_data = data
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