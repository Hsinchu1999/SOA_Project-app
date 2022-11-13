# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'
require_relative 'weather'

module TravellingSuggestions
  module Entity
    class Region < Dry::Struct
      include Dry.Types

      attribute :country,         Strict::String
      attribute :city,            Strict::String
      attribute :weather,         Weather

    end
  end
end