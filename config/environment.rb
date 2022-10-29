# frozen_string_literal: true

require 'roda'
require 'yaml'

module TravellingSuggestions
  class App < Roda
    CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
    CWB_TOKEN = CONFIG['cwb-gov']
  end
end