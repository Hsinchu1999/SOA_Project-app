# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object to update user favorite attractions
    class UpdateUserFavorite
      include Dry::Monads::Result::Mixin

      def call(nickname, attraction_ids, answers)
        Gateway::Api.new(TravellingSuggestions::App.config)
                    .update_user_favorite(attraction_id)
                    .then do |result|
          result.success? ? Success(result.payload) : Failure(result.message)
        end
      rescue StandardError
        Failure('could not access our API to update user favorites')
      end
    end
  end
end
