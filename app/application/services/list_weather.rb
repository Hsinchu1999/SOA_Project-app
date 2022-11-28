require 'dry/monads'

module TravellingSuggestions
  module Service
    class ListWeather
      include Dry::Monads::Result::Mixin

      def call(region_id)
        weather = Repository::ForAttraction.klass(Entity::Weather).find_region_id(region_id)
        Success(weather)
      rescue StandardError
        Failure('Could not fetch weather object from database')
      end
    end
  end
end