# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../lib/gateways/cwb_api.rb'

LOCATION = '新竹縣'
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
CWB_TOKEN = CONFIG['cwb-gov']
YML_FILE = YAML.safe_load(File.read('spec/fixtures/cwb_results.yml'))
CORRECTLOCATION = YML_FILE.select { |data| data['locationName'] == LOCATION }
CORRECTPOP = CORRECTLOCATION[0]['weatherElement'].select { |data| data['elementName'] == 'PoP' }[0]
CORRECTMINT = CORRECTLOCATION[0]['weatherElement'].select { |data| data['elementName'] == 'MinT' }[0]
CORRECTMAXT = CORRECTLOCATION[0]['weatherElement'].select { |data| data['elementName'] == 'MaxT' }[0]
UNAUTHORIZED = TravellingSuggestions::CWB::CWBApi::Response::Errors::Unauthorized

CASSETTE_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'cwb_api'
