# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class Forecast_Per_Day < Dry::Struct
      include Dry.Types

      attribute :PoP,             Strict::Integer
      attribute :minT,            Strict::Integer
      attribute :maxT,            Strict::Integer

    end
  end
end