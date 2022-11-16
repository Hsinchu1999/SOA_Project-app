# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    class ForecastPer12hrMapper
      attr_reader :pop,
                  :minT,
                  :maxT

      def initialize(pop, minT, maxT)
        @pop = pop
        @minT = minT
        @maxT = maxT
      end

      def build_entity
        Entity::Forecast_Per_12Hr.new(
        pop: @pop,
        minT: @minT,
        maxT: @maxT
        )
      end
    end
  end
end
  