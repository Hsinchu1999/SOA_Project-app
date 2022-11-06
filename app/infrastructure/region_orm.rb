# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class RegionOrm < Sequel::Model(:regions)
      one_to_many :local_attractions,
                  class: :'TravellingSuggestions::Database::AttractionOrm',
                  key: :in_region_id
      one_to_one :forecast_36hr,
                  class: :'TravellingSuggestions::Database::Forecast36hrOrm',
                  key: :region_id
      plugin :timestamps,update_on_create: true
    end
  end
end