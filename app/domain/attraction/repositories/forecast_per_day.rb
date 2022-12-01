# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    # An Repository object for Entity::ForecastPerDay
    class ForecastsPerDay
      def self.find_id(id)
        rebuild_entity Database::ForecastperDayOrm.first(id:)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::ForecastPerDay.new(
          pop:,
          minT:,
          maxT:
        )
      end

      def self.rebuild_many_entities(db_records)
        db_records.map do |db_member|
          Repository::ForecastPerDay.rebuild_entity(db_member)
        end
      end

      def self.db_find_or_create(_entity)
        nil
      end
      # to be completed
    end
  end
end
