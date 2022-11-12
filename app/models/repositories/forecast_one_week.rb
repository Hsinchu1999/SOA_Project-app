# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    class Forecasts_One_Week

      def self.find_region_id(region_id)
        rebuild_entity Database::ForecastOneWeekOrm.first(region_id: region_id)
      end
      
      def self.rebuild_entity(db_record)
        return nil unless db_record
        
        first_day_entity = Repository::Forecasts_Per_12Hr.find_id(db_record.forecast_first_12hr_id)
        second_12hr_entity = Repository::Forecasts_Per_12Hr.find_id(db_record.forecast_second_12hr_id)
        third_12hr_entity = Repository::Forecasts_Per_12Hr.find_id(db_record.forecast_last_12hr_id)

        Entity::Forecast_One_Week.new(
          forecast_report_time:       db_record.forecast_report_time,
          day1:   Repository::Forecasts_Per_Day.find_id(db_record.first_day_id),
          day2:   Repository::Forecasts_Per_Day.find_id(db_record.second_day_id),
          day3:   Repository::Forecasts_Per_Day.find_id(db_record.third_day_id),
          day4:   Repository::Forecasts_Per_Day.find_id(db_record.fourth_day_id),
          day5:   Repository::Forecasts_Per_Day.find_id(db_record.fifth_day_id),
          day6:   Repository::Forecasts_Per_Day.find_id(db_record.sixth_day_id),
          day7:   Repository::Forecasts_Per_Day.find_id(db_record.seventh_day_id),
        )
      end

      def self.rebuild_many_entities(db_records)
        db_records.map do | db_member |
          Repository::Forecasts_One_Week.rebuild_entity(db_member)
        end
      end

      def self.db_find_or_create(entity)
        nil
      end
      # to be completed

    end
  end
end