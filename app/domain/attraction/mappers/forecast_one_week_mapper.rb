# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    # Mapper for 1 week forecast
    class ForecastOneWeekMapper
      def initialize(cwb_token, gateway_class)
        @token = cwb_token
        @gateway_class = gateway_class
        @gateway = gateway_class.new(@token)
      end

      def find(location)
        data = @gateway.forecast_one_week(location)
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
          Entity::Forecast_One_Week.new(
            forecast_report_time: start_time,
            day1: build_per_day_entity(1),
            day2: build_per_day_entity(2),
            day3: build_per_day_entity(3),
            day4: build_per_day_entity(4),
            day5: build_per_day_entity(5),
            day6: build_per_day_entity(6),
            day7: build_per_day_entity(7)
          )
        end

        def build_per_day_entity(serial_index)
          pop = prob_rain(serial_index - 1)
          min_temp = min_temperature(serial_index - 1)
          max_temp = max_temperature(serial_index - 1)
          Mapper::ForecastPerDayMapper.new(pop, min_temp, max_temp).build_entity
        end

        def start_time
          @location_data['weatherElement'].select do |element|
            element['elementName'] == 'PoP12h'
          end[0]['time'][0]['startTime']
        end

        def prob_rain(serial_index)
          @location_data['weatherElement'].select do |element|
            element['elementName'] == 'PoP12h'
          end[0]['time'][2 * serial_index]['elementValue'][0]['value'].to_i
          # The prob of rain per 12 hr, so skip one in each day
          # thus the "2 * serial_index"
          # Need to call cwb api daily before 6AM
        end

        def min_temperature(serial_index)
          @location_data['weatherElement'].select do |element|
            element['elementName'] == 'MinT'
          end[0]['time'][2 * serial_index]['elementValue'][0]['value'].to_i
        end

        def max_temperature(serial_index)
          @location_data['weatherElement'].select do |element|
            element['elementName'] == 'MaxT'
          end[0]['time'][2 * serial_index]['elementValue'][0]['value'].to_i
        end
      end
    end
  end
end
