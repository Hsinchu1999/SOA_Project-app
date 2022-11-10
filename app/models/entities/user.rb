require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class User < Dry::Struct
      include Dry.Types

      attribute :id,                    Strict::Int
      attribute :nickname,              Strict::String
      attribute :mbti,                  Strict::String
      attribute :favorite_attractions,  Strict::Array.of(Attraction)

    end
  end
end