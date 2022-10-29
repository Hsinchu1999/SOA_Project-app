# frozen_string_literal: true

require 'roda'
require 'yaml'

module TravellingSuggestions
  class App < roda
    CONFIG = YAML.safe_load(File.read('config/secret.yml'))
    CWB_TOKEN = CONFIG['cwb-gov']
  end
end