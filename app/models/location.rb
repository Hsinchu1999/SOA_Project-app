# frozen_string_literal: true

module TravellingSuggestions
  # The data for each location
  class Location
    def initialize(name, data)
      @name = name
      @location_data = parse_location(data)
    end

    def parse_location(data)
      data['records']['location'].select { |element| element['locationName'] == @name }[0]
    end

    def prob_rain
      @location_data['weatherElement'].select { |element| element['elementName'] == 'PoP' }[0]
    end

    def min_temperature
      @location_data['weatherElement'].select { |element| element['elementName'] == 'MinT' }[0]
    end

    def max_temperature
      @location_data['weatherElement'].select { |element| element['elementName'] == 'MaxT' }[0]
    end
  end
end
