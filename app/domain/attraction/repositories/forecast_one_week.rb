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

      def self.db_find_or_create(region_entity)
        db_region = Database::RegionOrm.find_or_create(region_entity.to_attr_hash)
        db_forecast_1week = Database::ForecastOneWeekOrm.find_or_create(db_region.id)
        db_forecast_1week.update(forecast_report_time:region_entity.weather.forecast_one_week.forecast_report_time)

        if  db_forecast_1week.first_day_id == nil
          db_day_1 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day1.to_attr_hash)
          db_forecast_1week.update(first_day_id: db_day_1.id)
        else
          db_day_1 =  db_forecast_1week.first_day
          db_day_1.update(region_entity.weather.forecast_one_week.day1.to_attr_hash)
        end
        if  db_forecast_1week.second_day_id == nil
          db_day_2 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day2.to_attr_hash)
          db_forecast_1week.update(second_day_id: db_day_2.id)
        else
          db_day_2 =  db_forecast_1week.second_day
          db_day_2.update(region_entity.weather.forecast_one_week.day2.to_attr_hash)
        end
        if  db_forecast_1week.third_day_id == nil
          db_day_3 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day3.to_attr_hash)
          db_forecast_1week.update(third_day_id: db_day_3.id)
        else
          db_day_3 =  db_forecast_1week.third_day
          db_day_3.update(region_entity.weather.forecast_one_week.day3.to_attr_hash)
        end
        if  db_forecast_1week.fourth_day_id == nil
          db_day_4 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day4.to_attr_hash)
          db_forecast_1week.update(fourth_day_id: db_day_4.id)
        else
          db_day_4 =  db_forecast_1week.fourth_day
          db_day_4.update(region_entity.weather.forecast_one_week.day4.to_attr_hash)
        end
        if  db_forecast_1week.fifth_day_id == nil
          db_day_5 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day5.to_attr_hash)
          db_forecast_1week.update(fifth_day_id: db_day_5.id)
        else
          db_day_5 =  db_forecast_1week.fifth_day
          db_day_5.update(region_entity.weather.forecast_one_week.day5.to_attr_hash)
        end
        if  db_forecast_1week.sixth_day_id == nil
          db_day_6 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day6.to_attr_hash)
          db_forecast_1week.update(sixth_day_id: db_day_6.id)
        else
          db_day_6 =  db_forecast_1week.sixth_day
          db_day_6.update(region_entity.weather.forecast_one_week.day6.to_attr_hash)
        end
        if  db_forecast_1week.seventh_day_id == nil
          db_day_7 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day7.to_attr_hash)
          db_forecast_1week.update(seventh_day_id: db_day_7.id)
        else
          db_day_7 =  db_forecast_1week.seventh_day
          db_day_7.update(region_entity.weather.forecast_one_week.day7.to_attr_hash)
        end
        db_forecast_1week
      end
      # to be completed
    end
  end
end