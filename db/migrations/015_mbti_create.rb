# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:mbtis) do
      primary_key :id

      String :mbti_type
      String :description

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
