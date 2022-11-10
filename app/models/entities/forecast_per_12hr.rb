require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class Forecast_Per_12Hr < Dry::Struct
      include Dry.Types

      attribute :PoP,             Strict::Int
      attribute :minT,            Strict::Int
      attribute :maxT,            Strict::Int

    end
  end
end