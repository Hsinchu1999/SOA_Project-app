# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:MBTI_questions) do
      primary_key :id

      String :text
      String :section
      String :direction
      Integer :tier

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
