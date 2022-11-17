# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    class Locations
      def self.find_id(id)
        rebuild_entity Database::LocationOrm.first(id: id)
      end
    end
  end
end