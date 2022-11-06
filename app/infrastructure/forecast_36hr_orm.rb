# frozen_string_literal: true

require 'sequel'
=begin
module TravellingSuggestions
  module Database
    class Forecast36hrOrm < Sequel::Model(:forecast_36hrs)
      one_to_one :region,
                  class: :'TravellingSuggestions::Database::RegionOrm',
                  
                

      plugin :timestamps, update_on_create: true
    end
  end
end
=end