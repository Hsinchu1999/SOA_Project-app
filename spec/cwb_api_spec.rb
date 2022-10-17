# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/cwb_api'
require_relative 'spec_helper.rb'

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
      location = TravellingSuggestions::CWBApi.new(CWB_TOKEN).location(LOCATION)
      _(location.prob_rain).must_equal CORRECTPOP
      _(location.min_temperature).must_equal CORRECTMINT
      _(location.max_temperature).must_equal CORRECTMAXT
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do TravellingSuggestions::CWBApi.new('BAD_TOKEN').location(LOCATION) end).must_raise UNAUTHORIZED
    end
  end
end
