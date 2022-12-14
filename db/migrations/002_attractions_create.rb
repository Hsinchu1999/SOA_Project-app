# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:attractions) do
      primary_key :id
      foreign_key :in_region_id, :regions

      String :name, null: false
      String :indoor_or_outdoor
      String :main_activity
      String :staying_time
      String :type
      Integer :attendants
      String :notes
      String :contact
      String :best_time_to_visit

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
