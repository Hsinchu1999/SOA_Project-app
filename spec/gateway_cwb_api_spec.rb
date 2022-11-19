# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../cwb_api.rb'
require_relative 'helpers/vcr_helper'

describe 'Tests CWB API library' do
  #VcrHelper.setup_vcr
  
  before do
    VcrHelper.configure_vcr_for_cwb
  end

  after do
    VcrHelper.eject_vcr
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
      _(proc do TravellingSuggestions::CWB::CWBApi.new('BAD_TOKEN').forecast_36_hr(LOCATION) end).must_raise UNAUTHORIZED
    end
  end
end
