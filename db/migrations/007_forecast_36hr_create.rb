# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:forecast_36hrs) do
      primary_key :id
      foreign_key :region_id, :regions, unique: true
      foreign_key :forecast_first_12hr_id, :forecast_per_12hrs, unique: true
      foreign_key :forecast_second_12hr_id, :forecast_per_12hrs, unique: true
      foreign_key :forecast_last_12hr_id, :forecast_per_12hrs, unique: true

      String :forecast_report_time

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
