# frozen_string_literal: true

module TravellingSuggestions
    module Repository
      class Regions
        def self.find_id(id)
          rebuild_entity Database::RegionOrm.first(id: id)
        end
        
        def self.rebuild_entity(db_record)
          return nil unless db_record
          
          Entity::Region.new(
            country:       db_record.country,
            city:   db_record.city,
            weather:    nil,        # still needs to decide
          )
        end

        def self.rebuild_many_entities(db_records)
          db_records.map do | db_member |
            Repository::Regions.rebuild_entity(db_member)
          end
        end

        def self.db_find_or_create(entity)
          nil
        end
        # to be completed

      end
    end
  end