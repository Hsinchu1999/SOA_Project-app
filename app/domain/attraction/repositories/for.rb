# frozen_string_literal: true

require_relative 'attraction'
require_relative 'forecast_36hr'
require_relative 'forecast_one_week'
require_relative 'forecast_per_12hr'
require_relative 'forecast_per_day'
require_relative 'region'
require_relative 'weather'

module TravellingSuggestions
  module Repository
    # A For object for Attraction root aggregate
    module ForAttraction
      ENTITY_REPOSITORY = {
        Entity::Attraction => Attractions,
        Entity::Forecast_36Hr => Forecasts_36Hr,
        Entity::ForecastPer12Hr => ForecastsPer12Hr,
        Entity::Forecast_One_Week => Forecasts_One_Week,
        Entity::ForecastPerDay => ForecastsPerDay,
        Entity::Region => Regions,
        Entity::Weather => Weathers
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
