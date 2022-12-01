# frozen_string_literal: true

require 'dry/transaction'

module TravellingSuggestions
  module Service
    # A Service object to validate result from db
    class AddUser
      include Dry::Transaction

      step :check_no_use_username
      step :store_user

      private

      def check_no_use_username(input)
        if Repository::ForUser.klass(Entity::User).find_name(input['user_name'])
          Failure('Nickname already in use')
        else
          Success(input)
        end
      end

      def store_user(input)
        user_name = input['user_name']
        user = Repository::ForUser.klass(Entity::User).db_create(user_name)
        Success(user)
      rescue StandardError
        Failure('Having trouble accessing database')
      end
    end
  end
end
