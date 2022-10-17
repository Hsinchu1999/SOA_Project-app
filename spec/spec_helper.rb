# frozen_string_literal: true

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/cwb_api'

CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
CWB_TOKEN = CONFIG['cwb-gov']
YML_FILE = YAML.safe_load(File.read('spec/fixtures/cwb_results.yml'))
CORRECT = YML_FILE.select { |data| data['locationName'] == LOCATION }
CORRECTPOP = CORRECT[0]['weatherElement'].select { |data| data['elementName'] == 'PoP' }[0]
CORRECTMINT = CORRECT[0]['weatherElement'].select { |data| data['elementName'] == 'MinT' }[0]
CORRECTMAXT = CORRECT[0]['weatherElement'].select { |data| data['elementName'] == 'MaxT' }[0]
UNAUTHORIZED = TravellingSuggestions::CWBApi::Errors::Unauthorized

CASSETTE_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'cwb_api'
