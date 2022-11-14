# frozen_string_literal: true

module TravellingSuggestions
  module Mapper
    class ForecastPerDayMapper
      attr_reader :PoP,
                  :minT,
                  :maxT

      def initialize(PoP, minT, maxT)
        @PoP = PoP
        @minT = minT
        @maxT = maxT
      end

      def build_entity
        Entity::Forecast_Per_Day.new(
        PoP: @pop,
        minT: @minT,
        maxT: @maxT
        )
      end
    end
  end
end
    