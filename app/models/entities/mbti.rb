require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class MBTI < Dry::Struct
      include Dry.Types

      attribute :id,                    Strict::Int
      attribute :type,                  Strict::String
      attribute :description,           Strict::String

    end
  end
end