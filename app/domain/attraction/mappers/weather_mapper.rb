# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    # Mapper for weather
    class WeatherMapper
      def initialize(cwb_token, gateway_class)
        @token = cwb_token
        @gateway_class = gateway_class
      end

      def find(location)
        build_entity(location)
      end

      private

      def build_entity(location)
        Entity::Weather.new(
          forecast_36hr: build_forecast_36hr_entity(location),
          forecast_one_week: build_forecast_one_week_entity(location)
        )
      end

      def build_forecast_36hr_entity(location)
        Mapper::Forecast36hrMapper.new(@token, @gateway_class).find(location)
      end

      def build_forecast_one_week_entity(location)
        Mapper::ForecastOneWeekMapper.new(@token, @gateway_class).find(location)
      end
    end
  end
end
