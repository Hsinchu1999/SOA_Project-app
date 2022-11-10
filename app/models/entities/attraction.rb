require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class Attraction < Dry::Struct
      include Dry.Types

      attribute :id,                    Strict::Int
      attribute :added_time,            Strict::String
      attribute :region,                Strict::Region
      attribute :indoor_or_outdoor,     Strict::String
      attribute :main_activity,         Strict::String
      attribute :staying_time,          Strict::String
      attribute :type,                  Strict::String
      attribute :attendants,            Strict::Int
      attribute :notes,                 Strict::String
      attribute :contact,               Strict::String
      attribute :best_time_to_visit,    Stirct::String

    end
  end
end