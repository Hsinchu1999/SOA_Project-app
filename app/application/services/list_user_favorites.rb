# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object for validating Entity::User object from db
    class ListUserFavorites
      include Dry::Transaction

      step :call
      step :reify_user_favorites

      def call(input)
        if (user = Repository::ForUser.klass(Entity::User).find_name(input[:nickname]))
          puts 'success'
          Success(
            Response::ApiResult.new(
              status: :ok,
              message: user.favorite_attractions
            )
          )
        else
          Failure(
            Response::ApiResult.new(
              status: :not_found,
              message: 'User nickname does not exist'
            )
          )
        end
      end

      def reify_user_favorites(input)
        TravellingSuggestions::Representer::UserFavorite.new(OpenStruct.new)
        .from_json(input)
        .then{ |user_favorites| Success(user_favorites) }
      rescue StandardError
        Failure('Error in listing listing user\'s favorites, please try again')
      end
    end
  end
end
