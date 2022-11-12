# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:mbti_inoutdoor_ratings) do
      primary_key :id

      String :mbti
      String :indoor_or_outdoor
      Real :score

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
