# frozen_string_literal: true

module TravellingSuggestions
    module Mapper
      class Forecast36hrMapper
        attr_reader :data

        def initialize(data)
          @data = data
        end
  
        def build_entity
          Entity::Forecast_36Hr.new(
            forecast_report_time: get_start_time,
            first_12hr: _12hr_report(1),
            second_12hr: _12hr_report(2),
            third_12hr: _12hr_report(3)
          )
        end

        def _12hr_report(serial_time)
          pop = prob_rain(serial_time - 1)
          minT = min_temperature(serial_time - 1)
          maxT = max_temperature(serial_time - 1)
          Mapper::ForecastPer12hrMapper.new(pop, minT, maxT).build_entity
        end
        def get_start_time
          @data['weatherElement'].select { |element| element['elementName'] == 'PoP' }[0]['time'][0]['startTime']
        end
        def prob_rain(serial_time)
          @data['weatherElement'].select { |element| element['elementName'] == 'PoP' }[0]['time'][serial_time]['parameter']['parameterName'].to_i
        end
      
        def min_temperature(serial_time)
          @location_data['weatherElement'].select { |element| element['elementName'] == 'MinT' }[0]['time'][serial_time]['parameter']['parameterName'].to_i
        end
      
        def max_temperature(serial_time)
          @location_data['weatherElement'].select { |element| element['elementName'] == 'MaxT' }[0]['time'][serial_time]['parameter']['parameterName'].to_i
        end
        
      end
    end
end
  