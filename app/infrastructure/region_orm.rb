# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class RegionOrm < Sequel::Model(:regions)
      one_to_many :local_attractions,
                  class: :'TravellingSuggestions::Database::LocationOrm'

      plugin :timestamps,update_on_create: true
    end
  end
end