# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class Forecastper12hrOrm < Sequel::Model(:forecast_per_12hrs)
      one_to_one :forecast_first_12hr_in_36hr,
                  class: :'TravellingSuggestions::Database::Forecast36hrOrm',
                  key: :forecast_first_12hr_id

      one_to_one :forecast_second_12hr_in_36hr,
                  class: :'TravellingSuggestions::Database::Forecast36hrOrm',
                  key: :forecast_second_12hr_id

      one_to_one :forecast_last_12hr_in_36hr,
                  class: :'TravellingSuggestions::Database::Forecast36hrOrm',
                  key: :forecast_last_12hr_id

      plugin :timestamps, update_on_create: true
    end
  end
end
