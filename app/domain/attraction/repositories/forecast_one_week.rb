# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    # An Repository object for Entity::ForecastOneWeek
    class ForecastsOneWeek
      def self.find_region_id(region_id)
        rebuild_entity Database::ForecastOneWeekOrm.first(region_id:)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::ForecastOneWeek.new(
          forecast_report_time: db_record.forecast_report_time,
          day1: Repository::ForecastsPerDay.find_id(db_record.first_day_id),
          day2: Repository::ForecastsPerDay.find_id(db_record.second_day_id),
          day3: Repository::ForecastsPerDay.find_id(db_record.third_day_id),
          day4: Repository::ForecastsPerDay.find_id(db_record.fourth_day_id),
          day5: Repository::ForecastsPerDay.find_id(db_record.fifth_day_id),
          day6: Repository::ForecastsPerDay.find_id(db_record.sixth_day_id),
          day7: Repository::ForecastsPerDay.find_id(db_record.seventh_day_id)
        )
      end

      def self.rebuild_many_entities(db_records)
        db_records.map do |db_member|
          Repository::ForecastsOneWeek.rebuild_entity(db_member)
        end
      end

      def self.db_find_or_create(region_entity)
        db_region = Database::RegionOrm.find_or_create(region_entity.to_attr_hash)
        db_forecast_1week = Database::ForecastOneWeekOrm.find_or_create(db_region.id)
        db_forecast_1week.update(forecast_report_time: region_entity.weather.forecast_one_week.forecast_report_time)

        if db_forecast_1week.first_day_id.nil?
          db_day1 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day1.to_attr_hash)
          db_forecast_1week.update(first_day_id: db_day1.id)
        else
          db_day1 = db_forecast_1week.first_day
          db_day1.update(region_entity.weather.forecast_one_week.day1.to_attr_hash)
        end
        if db_forecast_1week.second_day_id.nil?
          db_day2 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day2.to_attr_hash)
          db_forecast_1week.update(second_day_id: db_day2.id)
        else
          db_day2 = db_forecast_1week.second_day
          db_day2.update(region_entity.weather.forecast_one_week.day2.to_attr_hash)
        end
        if db_forecast_1week.third_day_id.nil?
          db_day3 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day3.to_attr_hash)
          db_forecast_1week.update(third_day_id: db_day3.id)
        else
          db_day3 = db_forecast_1week.third_day
          db_day3.update(region_entity.weather.forecast_one_week.day3.to_attr_hash)
        end
        if db_forecast_1week.fourth_day_id.nil?
          db_day4 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day4.to_attr_hash)
          db_forecast_1week.update(fourth_day_id: db_day4.id)
        else
          db_day4 = db_forecast_1week.fourth_day
          db_day4.update(region_entity.weather.forecast_one_week.day4.to_attr_hash)
        end
        if db_forecast_1week.fifth_day_id.nil?
          db_day5 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day5.to_attr_hash)
          db_forecast_1week.update(fifth_day_id: db_day5.id)
        else
          db_day5 = db_forecast_1week.fifth_day
          db_day5.update(region_entity.weather.forecast_one_week.day5.to_attr_hash)
        end
        if db_forecast_1week.sixth_day_id.nil?
          db_day6 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day6.to_attr_hash)
          db_forecast_1week.update(sixth_day_id: db_day6.id)
        else
          db_day6 = db_forecast_1week.sixth_day
          db_day6.update(region_entity.weather.forecast_one_week.day6.to_attr_hash)
        end
        if db_forecast_1week.seventh_day_id.nil?
          db_day7 = Database::ForecastperDayOrm.create(region_entity.weather.forecast_one_week.day7.to_attr_hash)
          db_forecast_1week.update(seventh_day_id: db_day7.id)
        else
          db_day7 = db_forecast_1week.seventh_day
          db_day7.update(region_entity.weather.forecast_one_week.day7.to_attr_hash)
        end
        db_forecast_1week
      end
      # to be completed
    end
  end
end
