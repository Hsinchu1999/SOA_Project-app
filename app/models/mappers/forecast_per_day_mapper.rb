# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    class ForecastPerDayMapper
      attr_reader :pop,
                  :minT,
                  :maxT

      def initialize(pop, minT, maxT)
        @pop = pop
        @minT = minT
        @maxT = maxT
      end

      def build_entity
        Entity::Forecast_Per_Day.new(
        pop: @pop,
        minT: @minT,
        maxT: @maxT
        )
      end
    end
  end
end
    