# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    class WeatherMapper
      def initialize(cwb_token, gateway_class)
        @token = cwb_token
        @gateway_class = gateway_class
        @gateway = gateway_class.new(@token)
      end
    
      def find(location)
        data = @gateway.location_data(location)
        build_entity(data)
      end

      def build_entity(data)
        Entity::Weather.new(
          forecast_36hr: forecast_36hr_report(data)
        )
      end

      def forecast_36hr_report(data)
        Mapper::Forecast36hrMapper.new(data[0]).build_entity
      end
    end
  end
end
  