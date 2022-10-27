# frozen_string_literal: true

require_relative 'spec_helper'
require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/gateways/cwb_api.rb'

describe 'Tests CWB API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTE_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<CWB_TOKEN>') { CWB_TOKEN }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes, match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Location information' do
    it 'HAPPY: should provide correct location attributes' do
      location = TravellingSuggestions::CWB::LocationMapper.new(CWB_TOKEN, TravellingSuggestions::CWB::CWBApi).find(LOCATION)
      _(location.name).must_equal LOCATION
      _(location.prob_rain).must_equal CORRECTPOP
      _(location.min_temperature).must_equal CORRECTMINT
      _(location.max_temperature).must_equal CORRECTMAXT
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do TravellingSuggestions::CWB::CWBApi.new('BAD_TOKEN').location_data(LOCATION) end).must_raise UNAUTHORIZED
    end
  end
end
