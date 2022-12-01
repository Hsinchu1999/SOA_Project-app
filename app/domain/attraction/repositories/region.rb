# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    # An Repository object for Entity::Region
    class Regions
      def self.find_id(id)
        rebuild_entity Database::RegionOrm.first(id:)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Region.new(
          country: db_record.country,
          city: db_record.city,
          weather: Repository::Weathers.find_region_id(db_record.id)
        )
      end

      def self.rebuild_many_entities(db_records)
        db_records.map do |db_member|
          Repository::Regions.rebuild_entity(db_member)
        end
      end

      def self.db_find_or_create(entity)
        Database::RegionOrm.find_or_create(entity.to_attr_hash)
      end
      # to be completed
    end
  end
end
