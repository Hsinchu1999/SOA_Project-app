require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class MBTI_Question < Dry::Struct
      include Dry.Types

      attribute :id,                    Strict::Int
      attribute :text,                  Strict::String
      attribute :section,               Strict::String
      attribute :direction,             Strict::String
      attribute :tier,                  Strict::Int

    end
  end
end