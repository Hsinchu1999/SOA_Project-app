# frozen_string_literal: true

require_relative 'helpers/api_helper'
require_relative 'helpers/vcr_helper'

describe 'Tests CWB API library' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_cwb
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Check API alive' do
    it 'should check api alive' do
      alive = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).alive?
      _(alive).must_equal true
    end
  end
end
