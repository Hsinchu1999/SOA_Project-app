# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class Forecast36hrOrm < Sequel::Model(:forecast_36hrs)
      many_to_one :region,
                  class: :'TravellingSuggestions::Database::RegionOrm'
      
      many_to_one :forecast_first_12hr,
                  class: :'TravellingSuggestions::Database::Forecastper12hrOrm'

      many_to_one :forecast_second_12hr,
                  class: :'TravellingSuggestions::Database::Forecastper12hrOrm'

      many_to_one :forecast_last_12hr,
                  class: :'TravellingSuggestions::Database::Forecastper12hrOrm'
                    
      plugin :timestamps, update_on_create: true
      
      def self.find_or_create(region_id)
        first(region_id: region_id) || create(region_id: region_id)
      end
    end
  end
end
