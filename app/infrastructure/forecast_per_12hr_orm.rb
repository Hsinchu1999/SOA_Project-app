# frozen_string_literal: true

require 'sequel'
=begin
module TravellingSuggestions
  module Database
    class Forecastper12hrOrm < Sequel::Model(:forecast_per_12hrs)
      one_to_one :favorite_attractions,
                    class: :'TravellingSuggestions::Database::AttractionOrm',
                    join_table: :users_favorites,
                    left_key: :user_id, right_key: :favorite_id
                

      plugin :timestamps, update_on_create: true
    end
  end
end
=end