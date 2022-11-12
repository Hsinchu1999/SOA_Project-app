# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'
require_relative 'region'

module TravellingSuggestions
  module Entity
    class Attraction < Dry::Struct
      include Dry.Types

      attribute :id,                    Strict::Integer
      attribute :added_time,            Strict::String
      attribute :region,                Region
      attribute :indoor_or_outdoor,     Strict::Symbol
      attribute :main_activity,         Strict::String
      attribute :staying_time,          Strict::String
      attribute :type,                  Strict::String
      attribute :attendants,            Strict::Integer
      attribute :notes,                 Strict::String
      attribute :contact,               Strict::String
      attribute :best_time_to_visit,    Strict::String

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end