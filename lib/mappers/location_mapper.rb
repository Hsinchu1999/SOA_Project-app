module CodePraise
  module Github
    class LocationMapper
      def initialize(cwb_token, gateway_class)
        @token = cwb_token
        @gateway_class = gateway_class
        @gateway = gateway_class.new(@token)
      end

      def load_several(url)
        @gateway.contributors_data(url).map do |data|
          LocationMapper.build_entity(data)
        end
      end

      def self.build_entity(data)
        DataMapper.new(data).build_entity
      end

      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          Entity::Location.new(
            prob_rain:,
            min_temperature:,
            max_temperature:
          )
        end

        private

        def prob_rain
          @data['PoP']
        end

        def min_temperature
          @data['MinT']
        end

        def max_temperature
          @data['MaxT']
        end
      end
    end
  end
end