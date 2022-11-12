# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:forecast_one_weeks) do
      primary_key :id
      foreign_key :region_id, :regions, unique: true
      foreign_key :first_day, :forecast_per_days, unique: true
      foreign_key :second_day, :forecast_per_days, unique: true
      foreign_key :third_day, :forecast_per_days, unique: true
      foreign_key :fourth_day, :forecast_per_days, unique: true
      foreign_key :fifth_day, :forecast_per_days, unique: true
      foreign_key :sixth_day, :forecast_per_days, unique: true
      foreign_key :seventh_day, :forecast_per_days, unique: true
      
      String :forecast_report_time

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
