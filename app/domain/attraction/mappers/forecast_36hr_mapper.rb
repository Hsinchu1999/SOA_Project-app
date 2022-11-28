# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    # Mapper for 36hr forecast
    class Forecast36hrMapper
      def initialize(cwb_token, gateway_class)
        @token = cwb_token
        @gateway_class = gateway_class
        @gateway = gateway_class.new(@token)
      end

      def find(location)
        data = @gateway.forecast_36_hr(location)
        build_entity(location, data)
      end

      def build_entity(location, data)
        DataMapper.new(location, data).build_entity
      end

      # extracts entity specific elements from data structure
      class DataMapper
        def initialize(location, data)
          @location = location
          @location_data = data[0]
        end

        def build_entity
          Entity::Forecast_36Hr.new(
            forecast_report_time: start_time,
            first_12hr: _12hr_report(1),
            second_12hr: _12hr_report(2),
            third_12hr: _12hr_report(3)
          )
        end

        def _12hr_report(serial_index)
          pop = prob_rain(serial_index - 1)
          min_temp = min_temperature(serial_index - 1)
          max_temp = max_temperature(serial_index - 1)
          Mapper::ForecastPer12hrMapper.new(pop, min_temp, max_temp).build_entity
        end

        def start_time
          @location_data['weatherElement'].select do |element|
            element['elementName'] == 'PoP'
          end[0]['time'][0]['startTime']
        end

        def prob_rain(serial_index)
          @location_data['weatherElement'].select do |element|
            element['elementName'] == 'PoP'
          end[0]['time'][serial_index]['parameter']['parameterName'].to_i
        end

        def min_temperature(serial_index)
          @location_data['weatherElement'].select do |element|
            element['elementName'] == 'MinT'
          end[0]['time'][serial_index]['parameter']['parameterName'].to_i
        end

        def max_temperature(serial_index)
          @location_data['weatherElement'].select do |element|
            element['elementName'] == 'MaxT'
          end[0]['time'][serial_index]['parameter']['parameterName'].to_i
        end
      end
    end
  end
end
