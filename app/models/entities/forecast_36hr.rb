require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class Forecast_36Hr < Dry::Struct
      include Dry.Types

      attribute :forecast_report_time,  Strict::String
      attribute :first_12hr,            Strict::Forecast_Per_12Hr
      attribute :second_12hr,           Strict::Forecast_Per_12Hr
      attribute :third_12hr,            Strict::Forecast_Per_12Hr

    end
  end
end