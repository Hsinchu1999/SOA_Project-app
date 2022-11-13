# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'
require_relative 'forecast_per_12hr'

module TravellingSuggestions
  module Entity
    class Forecast_36Hr < Dry::Struct
      include Dry.Types

      attribute :forecast_report_time,  Strict::String
      attribute :first_12hr,            Forecast_Per_12Hr
      attribute :second_12hr,           Forecast_Per_12Hr
      attribute :third_12hr,            Forecast_Per_12Hr

    end
  end
end