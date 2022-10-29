module TravellingSuggestions
  module CWB
    class LocationMapper
      def initialize(cwb_token, gateway_class)
        @token = cwb_token
        @gateway_class = gateway_class
        @gateway = gateway_class.new(@token)
      end
      
      def find(location)
        data = @gateway.location_data(location)
        build_entity(location, data)
      end

      def build_entity(location, data)
        DataMapper.new(location, data).build_entity
      end

      class DataMapper
        def initialize(location, data)
          @location = location
          @location_data = parse_location(data)
        end

        def build_entity
          TravellingSuggestions::Entity::Location.new(
            name: @location,
            prob_rain: prob_rain,
            min_temperature: min_temperature,
            max_temperature: max_temperature
          )
        end
        
        private
        def parse_location(data)
          data[0]
        end
    
        def prob_rain
          res = @location_data['weatherElement'].select { |element| element['elementName'] == 'PoP' }[0]['time'][0]['parameter']['parameterName'].to_i
        end
    
        def min_temperature
          res = @location_data['weatherElement'].select { |element| element['elementName'] == 'MinT' }[0]['time'][0]['parameter']['parameterName'].to_i
        end
    
        def max_temperature
          res = @location_data['weatherElement'].select { |element| element['elementName'] == 'MaxT' }[0]['time'][0]['parameter']['parameterName'].to_i
        end
      end
    end
  end
end