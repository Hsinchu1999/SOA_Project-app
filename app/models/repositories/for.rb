# frozen_string_literal: true

require_relative 'attraction'
require_relative 'forecast_36hr'
require_relative 'forecast_per_12hr'
require_relative 'mbti_question'
require_relative 'region'
require_relative 'user'

module TravellingSuggestions
  module Repository
    module For

      ENTITY_REPOSITORY = {
        Entity::Attraction => Attractions,
        Entity::Forecast_36Hr => Forecasts_36Hr,
        Entity::Forecast_Per_12Hr => Forecasts_Per_12Hr,
        Entity::MBTI_Question => MBTI_Questions,
        Entity::Region => Regions,
        Entity::User => Users,
        #Entity::Weather => Weathers
      }.freeze

      def self.klass(entity_klass)
        ENTITY_REPOSITORY[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_REPOSITORY[entity_object.class]
      end

    end
  end
end