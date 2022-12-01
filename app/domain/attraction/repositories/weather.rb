# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    # An Repository object for Entity::Weather
    class Weathers
      def self.find_region_id(region_id)
        rebuild_entity(region_id)
      end

      def self.find_region_ids(region_ids)
        region_ids.map do |region_id|
          rebuild_entity(region_id)
        end
      end

      def self.rebuild_entity(region_id)
        forecast_36hr_entity = Repository::Forecasts_36Hr.find_region_id(region_id)
        forecast_one_week_entity = Repository::Forecasts_One_Week.find_region_id(region_id)

        Entity::Weather.new(
          forecast_36hr: forecast_36hr_entity,
          forecast_one_week: forecast_one_week_entity
        )
      end

      def self.db_find_or_create(_entity)
        nil
      end
      # to be completed
    end
  end
end
