# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module TravellingSuggestions
  module Representer
    # Representer for a set of Attractions
    class AttractionSet < Roar::Decorator
      include Roar::JSON

      property :attraction_set
    end
  end
end
  