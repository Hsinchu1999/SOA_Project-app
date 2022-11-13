# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    class RegionMapper
      attr_reader :country,
                  :city,
                  :weather
    
      def initialize(country, city, weather)
        @country = country
        @city = city
        @weather = weather
      end

      def build_entity
        Entity::Region.new(
          country = @country,
          city = @city,
          weather = @weather
        )
      end
    end
  end
end
    