module TravellingSuggestions
    module Repository
      class Forecasts_Per_36Hr
        def self.find_id(id)
          rebuild_entity Database::Forecast36hrOrm.first(id: id)
        end

        def self.find_region_id(region_id)
          rebuild_entity Database::Forecast36hrOrm.first(region_id: region_id)
        end
        
        def self.rebuild_entity(db_record)
          return nil unless db_record
          
          first_12hr_entity = Repository::Forecasts_Per_12Hr.find_id(db_record.forecast_first_12hr_id)
          second_12hr_entity = Repository::Forecasts_Per_12Hr.find_id(db_record.forecast_second_12hr_id)
          third_12hr_entity = Repository::Forecasts_Per_12Hr.find_id(db_record.forecast_last_12hr_id)

          Entity::Forecast_36Hr.new(
            forecast_report_time:       db_record.forecast_report_time,
            first_12hr:   first_12hr_entity,
            second_12hr:   second_12hr_entity,
            third_12hr:     third_12hr_entity
          )
        end

        def self.rebuild_many_entities(db_records)
          db_records.map do | db_member |
            Repository::Forecasts_Per_36Hr.rebuild_entity(db_member)
          end
        end

        def self.db_find_or_create(entity)
          nil
        end
        # to be completed

      end
    end
  end