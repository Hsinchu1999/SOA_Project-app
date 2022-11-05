# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class LocationOrm < Sequel::Model(:regions)
      many_to_one :in_region,
                  class: :'TravellingSuggestions::Database::RegionOrm'

      plugin :timestamps,update_on_create: true
    end
  end
end