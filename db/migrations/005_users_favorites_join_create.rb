# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:users_favorites) do
      primary_key %i[user_id favorite_id]
      foreign_key :user_id, :users
      foreign_key :favorite_id, :attractions

      index %i[user_id favorite_id]
    end
  end
end
