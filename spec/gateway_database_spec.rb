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
      _(rebuilt_region.city).must_equal region.city
      _(rebuilt_forecast36hr.region.city).must_equal region.city
      _(rebuilt_forecast36hr.forecast_first_12hr.pop).must_equal weather.forecast_36hr.first_12hr.pop
      _(rebuilt_forecast36hr.forecast_second_12hr.pop).must_equal weather.forecast_36hr.second_12hr.pop
      _(rebuilt_forecast36hr.forecast_last_12hr.pop).must_equal weather.forecast_36hr.third_12hr.pop
    end
  end
end