# frozen_string_literal: true

require 'vcr'
require 'webmock'

# Setting up VCR
module VcrHelper
  CASSETTE_FOLDER = 'spec/fixtures/cassettes'
  CASSETTE_FILE = 'cwb_api'

  def self.setup_vcr
    VCR.configure do |c|
      c.cassette_library_dir = CASSETTE_FOLDER
      c.hook_into :webmock
    end
  end

  def self.configure_vcr_for_cwb
    VCR.configure do |c|
      c.filter_sensitive_data('<CWB_TOKEN>') { CWB_TOKEN }
    end
    VCR.insert_cassette(CASSETTE_FILE, record: :new_episodes, match_requests_on: %i[method uri headers])
  end

  def self.eject_vcr
    VCR.eject_cassette
  end
end
