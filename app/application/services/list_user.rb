# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object for validating Entity::User object from db
    class ListUser
      include Dry::Monads::Result::Mixin

      def call(_input)
        if (user = Repository::ForUser.klass(Entity::User).find_name(nick_name))
          Success(user)
        else
          Failure('Could not access database')
        end
      end
    end
  end
end
