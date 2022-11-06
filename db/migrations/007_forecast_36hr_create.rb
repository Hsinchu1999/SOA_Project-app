# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:forecast_36hrs) do
      primary_key :id
      foreign_key :region_id, :regions
      foreign_key :forecast_next_12hr_id, :forecast_per_12hrs
      foreign_key :forecast_next_24hr_id, :forecast_per_12hrs
      foreign_key :forecast_next_36hr_id, :forecast_per_12hrs
      
      String :forecast_report_time

      DateTime :created_at
      DateTime :updated_at
    end
  end
end