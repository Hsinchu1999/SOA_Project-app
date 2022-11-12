# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:user_active_ratings) do
      primary_key [:user_id, :attraction_id]
      foreign_key :user_id, :users
      foreign_key :attraction_id, :attractions

      add_column :score, type: :Integer

      index [:user_id, :attraction_id]
    end
  end
end
