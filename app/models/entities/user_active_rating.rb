# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'
require_relative 'region'

module TravellingSuggestions
  module Entity
    class User_Active_Ratings < Dry::Struct
      include Dry.Types

      attribute :user,                  User
      attribute :attraction,            Attraction
      attribute :score,                 Strict::Integer

      def to_attr_hash
        to_hash.except(:id)
      end
    end
  end
end