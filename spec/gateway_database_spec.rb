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
      _(rebuilt_region.city).must_equal region.city
    end
  end
end