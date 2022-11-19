# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/database_helper'
require_relative 'helpers/vcr_helper'
require 'pry'

describe 'Integration Tests of CWB API and Database' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_cwb
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store project' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to save project from CWB to database' do
      
      region = TravellingSuggestions::Mapper::RegionMapper.new('Taiwan',LOCATION).find_weather(CWB_TOKEN)
      weather = region.weather
      rebuilt_region = TravellingSuggestions::Repository::Regions.db_find_or_create(region)
      rebuilt_forecast36hr = TravellingSuggestions::Repository::Forecasts_36Hr.db_find_or_create(region)
      rebuilt_forecast1w = TravellingSuggestions::Repository::Forecasts_One_Week.db_find_or_create(region)
      _(rebuilt_region.city).must_equal region.city
      _(rebuilt_forecast36hr.region.city).must_equal region.city
      _(rebuilt_forecast36hr.forecast_first_12hr.pop).must_equal weather.forecast_36hr.first_12hr.pop
      _(rebuilt_forecast36hr.forecast_second_12hr.pop).must_equal weather.forecast_36hr.second_12hr.pop
      _(rebuilt_forecast36hr.forecast_last_12hr.pop).must_equal weather.forecast_36hr.third_12hr.pop
      _(rebuilt_forecast1w.region.city).must_equal region.city
      _(rebuilt_forecast1w.first_day.pop).must_equal weather.forecast_one_week.day1.pop
      _(rebuilt_forecast1w.second_day.pop).must_equal weather.forecast_one_week.day2.pop
      _(rebuilt_forecast1w.third_day.pop).must_equal weather.forecast_one_week.day3.pop
      _(rebuilt_forecast1w.fourth_day.pop).must_equal weather.forecast_one_week.day4.pop
      _(rebuilt_forecast1w.fifth_day.pop).must_equal weather.forecast_one_week.day5.pop
      _(rebuilt_forecast1w.sixth_day.pop).must_equal weather.forecast_one_week.day6.pop
      _(rebuilt_forecast1w.seventh_day.pop).must_equal weather.forecast_one_week.day7.pop
    end
  end
end