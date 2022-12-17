# frozen_string_literal: true

require 'dry/transaction'

module TravellingSuggestions
  module Service
    # A Service object to validate result from db
    class AddUser
      include Dry::Transaction

      step :check_valid_username
      step :check_no_use_username
      step :reify_user

      private

      def check_valid_username(input)
        res = TravellingSuggestions::Forms::NewUserNickname.new.call(input)
        if res.failure?
          Failure('Invalid username')
        else
          Success(input)
        end
      end

      def check_no_use_username(input)
        nickname = input[:nickname]
        mbti_type = input[:mbti_type]
        
        result = Gateway::Api.new(TravellingSuggestions::App.config).add_user(nickname, mbti_type)
        
        result.success? ? Success(result.payload) : Failure(result.message)
      rescue StandardError
        Failure('Cannot construct user profile right now; please try again later')
      end

      def reify_user(input)
        TravellingSuggestions::Representer::User.new(OpenStruct.new)
          .from_json(input)
          .then{ |user| Success(user) }
      rescue StandardError
        Failure('Error in constructing user profile, please try again')
      end
    end
  end
end
