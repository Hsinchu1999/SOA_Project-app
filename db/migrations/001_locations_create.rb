# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:locations) do
      primary_key :id
      foreign_key :region_id, :regions

      String :indoor_or_outdoor
      String :main_activity
      Integer :staying_time
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