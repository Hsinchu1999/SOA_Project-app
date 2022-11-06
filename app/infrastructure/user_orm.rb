# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class UserOrm < Sequel::Model(:users)
      many_to_many :favorite_attractions,
                    class: :'TravellingSuggestions::Database::AttractionOrm',
                    join_table: :users_favorites,
                    left_key: :user_id, right_key: :favorite_id
                

      plugin :timestamps, update_on_create: true
    end
  end
end