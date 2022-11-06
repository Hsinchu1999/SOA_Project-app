# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class AttractionOrm < Sequel::Model(:attractions)
      many_to_one :in_region,
                  class: :'TravellingSuggestions::Database::RegionOrm'
      
      many_to_many :users_favorited,
                    class: :'TravellingSuggestions::Database::UserOrm',
                    join_table: :users_favorites,
                    left_key: :favorite_id, right_key: :user_id

      plugin :timestamps,update_on_create: true
    end
  end
end