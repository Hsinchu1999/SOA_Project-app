# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    # An Repository object for Entity::Location
    class Locations
      def self.find_id(id)
        rebuild_entity Database::LocationOrm.first(id:)
      end
    end
  end
end
