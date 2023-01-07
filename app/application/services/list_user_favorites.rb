# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object for validating Entity::User object from db
    class ListUserFavorites
      include Dry::Transaction

      step :call_api
      step :reify_user_favorites

      def call_api(input)
        nickname = input[:nickname]
        TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config)
          .list_user_favorites(nickname)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
        end
      rescue
        Failure('Could not access our Api for user favorites')
      end

      def reify_user_favorites(input)
        TravellingSuggestions::Representer::UserFavorite.new(OpenStruct.new)
                                                        .from_json(input)
                                                        .then { |user_favorites| Success(user_favorites) }
      rescue StandardError
        Failure('Error in listing listing user\'s favorites, please try again')
      end
    end
  end
end
