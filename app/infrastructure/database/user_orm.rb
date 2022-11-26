# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class UserOrm < Sequel::Model(:users)
      many_to_many :favorite_attractions,
                    class: :'TravellingSuggestions::Database::AttractionOrm',
                    join_table: :users_favorites,
                    left_key: :user_id, right_key: :favorite_id

      many_to_many :rated_attractions,
                    class: :'TravellingSuggestions::Database::AttractionOrm',
                    join_table: :user_active_ratings,
                    left_key: :user_id, right_key: :attraction_id,
                    adder: (lambda do |attraction, score: nil|
                            self.db[:user_active_ratings].insert(user_id: self.id, attraction_id:attraction.id, score: score)
                           end)

      plugin :timestamps, update_on_create: true
    end
  end
end
