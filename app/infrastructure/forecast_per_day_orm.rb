# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class ForecastperDayOrm < Sequel::Model(:forecast_per_days)
      one_to_one :first_day_in_week,
                  class: :'TravellingSuggestions::Database::ForecastOneWeekOrm',
                  key: :first_day_id

      one_to_one :second_day_in_week,
                  class: :'TravellingSuggestions::Database::ForecastOneWeekOrm',
                  key: :second_day_id

      one_to_one :third_day_in_week,
                  class: :'TravellingSuggestions::Database::ForecastOneWeekOrm',
                  key: :third_day_id

      one_to_one :fourth_day_in_week,
                  class: :'TravellingSuggestions::Database::ForecastOneWeekOrm',
                  key: :fourth_day_id
      
      one_to_one :fifth_day_in_week,
                  class: :'TravellingSuggestions::Database::ForecastOneWeekOrm',
                  key: :fifth_day_id
      
      one_to_one :sixth_day_in_week,
                  class: :'TravellingSuggestions::Database::ForecastOneWeekOrm',
                  key: :sixth_day_id

      one_to_one :seventh_day_in_week,
                  class: :'TravellingSuggestions::Database::ForecastOneWeekOrm',
                  key: :seventh_day_id
                  
      plugin :timestamps, update_on_create: true
    end
  end
end
