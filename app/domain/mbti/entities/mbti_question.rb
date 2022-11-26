# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class MBTI_Question < Dry::Struct
      include Dry.Types

      attribute :id,                    Strict::Integer
      attribute :question,              Strict::String
      attribute :answerA,               Strict::String
      attribute :answerB,               Strict::String
      attribute :section,               Strict::String
      attribute :directionA,            Strict::String
      attribute :scoreA,                Strict::Integer
      attribute :scoreB,                Strict::Integer

    end
  end
end