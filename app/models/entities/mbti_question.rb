# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class MBTI_Question < Dry::Struct
      include Dry.Types

      attribute :id,                    Strict::Integer
      attribute :text,                  Strict::String
      attribute :section,               Strict::String
      attribute :direction,             Strict::String
      attribute :tier,                  Strict::Integer

    end
  end
end