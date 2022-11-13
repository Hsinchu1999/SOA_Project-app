# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:mbti_mainactivity_ratings) do
      primary_key :id

      String :mbti
      String :main_activity
      Real :score

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
