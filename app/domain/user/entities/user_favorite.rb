# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TravellingSuggestions
  module Entity
    class User_Favorite < Dry::Struct
      include Dry.Types

      attribute :favorites_list,        Strict::Array.of(Attraction)

      def retrieve_all
        self.sort
      end

      def add_new(new_attraction)
        favorites_list = favorites_list.append(new_attraction)
      end

      private
      
      def sort
        # could extend sorting methods here
        favorites_list
      end
    end
  end
end