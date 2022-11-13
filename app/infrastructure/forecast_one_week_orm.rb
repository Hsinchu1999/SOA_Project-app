# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class ForecastOneWeekOrm < Sequel::Model(:forecast_one_weeks)
      many_to_one :region,
                  class: :'TravellingSuggestions::Database::RegionOrm'
      
      many_to_one :first_day,
                  class: :'TravellingSuggestions::Database::ForecastperDayOrm'

      many_to_one :second_day,
                  class: :'TravellingSuggestions::Database::ForecastperDayOrm'

      many_to_one :third_day,
                  class: :'TravellingSuggestions::Database::ForecastperDayOrm'

      many_to_one :fourth_day,
                  class: :'TravellingSuggestions::Database::ForecastperDayOrm'

      many_to_one :fifth_day,
                  class: :'TravellingSuggestions::Database::ForecastperDayOrm'

      many_to_one :sixth_day,
                  class: :'TravellingSuggestions::Database::ForecastperDayOrm'

      many_to_one :seventh_day,
                  class: :'TravellingSuggestions::Database::ForecastperDayOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
