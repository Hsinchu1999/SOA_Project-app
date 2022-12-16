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
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config)
          .list_user(input[:nickname])
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_user(input)
        puts 'in reify_user'
        TravellingSuggestions::Representer::User.new(OpenStruct.new)
        .from_json(input)
        .then{ |user| Success(user) }
      rescue StandardError
        Failure('Error in listing user, please try again')
      end
    end
  end
end
