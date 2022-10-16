# frozen_string_literal: true

require 'minitest/autorun'
require 'yaml'
require_relative '../lib/cwb_api'

LOCATION = '新竹縣'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
CWB_TOKEN = CONFIG['cwb-gov']
YML_FILE = YAML.safe_load(File.read('spec/fixtures/cwb_results.yml'))
CORRECT = YML_FILE.select { |data| data['locationName'] == LOCATION }
CORRECTPOP = CORRECT[0]['weatherElement'].select { |data| data['elementName'] == 'PoP' }[0]
CORRECTMINT = CORRECT[0]['weatherElement'].select { |data| data['elementName'] == 'MinT' }[0]
CORRECTMAXT = CORRECT[0]['weatherElement'].select { |data| data['elementName'] == 'MaxT' }[0]
UNAUTHORIZED = TravellingSuggestions::CWBApi::Errors::Unauthorized
describe 'Tests CWB API library' do
  describe 'Location information' do
    it 'HAPPY: should provide correct location attributes' do
      location = TravellingSuggestions::CWBApi.new(CWB_TOKEN).location(LOCATION)
      _(location.prob_rain).must_equal CORRECTPOP
      _(location.min_temperature).must_equal
      _(location.max_temperature).must_equal
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do TravellingSuggestions::CWBApi.new('BAD_TOKEN').location(LOCATION) end).must_raise UNAUTHORIZED
    end
  end
end
