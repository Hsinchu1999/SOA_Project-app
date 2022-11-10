require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class Weather < Dry::Struct
      include Dry.Types

      attribute :forecast_36hr,             Strict::Forecast_36Hr
      attribute :forecast_one_week,         Strict::Forecast_One_Week

    end
  end
end