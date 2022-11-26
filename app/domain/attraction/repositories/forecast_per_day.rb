# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    class Forecasts_Per_Day

      def self.find_id(id)
        rebuild_entity Database::ForecastperDayOrm.first(id: id)
      end
      
      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Forecast_Per_Day.new(
          pop:        pop,
          minT:       minT,
          maxT:       maxT
        )
      end

      def self.rebuild_many_entities(db_records)
        db_records.map do | db_member |
          Repository::Forecast_Per_Day.rebuild_entity(db_member)
        end
      end

      def self.db_find_or_create(entity)
        nil
      end
      # to be completed

    end
  end
end