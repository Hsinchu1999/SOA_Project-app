# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module TravellingSuggestions
  module Representer
    # Represent about mbti question
    class MBTIQuestionSet < Roar::Decorator
      include Roar::JSON

      property :question_set
    end
  end
end
