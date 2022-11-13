# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class Location < Dry::Struct
      include Dry.Types

      attribute :name,             Strict::String
      attribute :prob_rain,        Strict::Integer
      attribute :min_temperature,  Strict::Integer
      attribute :max_temperature,  Strict::Integer
    end
  end
end
