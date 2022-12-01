# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    # An Entity object for each mbti type
    class MBTI < Dry::Struct
      include Dry.Types

      attribute :id,                    Strict::Integer
      attribute :type,                  Strict::String
      attribute :description,           Strict::String
    end
  end
end
