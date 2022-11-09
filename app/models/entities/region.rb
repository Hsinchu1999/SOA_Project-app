require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class Region < Dry::Struct
      include Dry.Types

      attribute :country,         Strict::String
      attribute :city,            Strict::String

    end
  end
end