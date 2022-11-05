# frozen_string_literal: true

require 'sequal'

Sequel.migration do
    change do
      create_tabel(:regions) do
        primary_key :id
        
        String :country
        String :city
        String :area

        DateTime :created_at
        DateTime :updated_at
      end
    end
  end