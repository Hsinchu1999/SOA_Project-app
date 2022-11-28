# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    # Mapper for Region
    class RegionMapper
      attr_reader :country,
                  :city,
                  :weather

      def initialize(country, city)
        @country = country
        @city = city
      end

      def find_weather(token)
        build_entity(token)
      end

      private

      def build_entity(token)
        Entity::Region.new(
          country: @country,
          city: @city,
          weather: Mapper::WeatherMapper.new(token, TravellingSuggestions::CWB::CWBApi).find(@city)
        )
      end
    end
  end
end
