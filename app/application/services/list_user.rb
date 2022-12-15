# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object for validating Entity::User object from db
    class ListUser
      include Dry::Transaction

      step :call
      step :reify_user

      def call(input)
        if (user = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).list_user(input[:nickname]))
          Success(
            Response::ApiResult.new(
              status: :ok,
              message: user
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

      def reify_user(input)
        TravellingSuggestions::Representer::User.new(OpenStruct.new)
        .from_json(input)
        .then{ |user| Success(user) }
      rescue StandardError
        Failure('Error in listing user, please try again')
      end
    end
  end
end
