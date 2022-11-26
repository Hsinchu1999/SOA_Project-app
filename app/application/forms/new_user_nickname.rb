require 'dry-validation'

module TravellingSuggestions
  module Forms
    class NewUserNickname < Dry::Validation::Contract

      NICKNAME_REGEX = %r{/^\w+$/}.freeze

      params do
        required(:nickname).filled(:string)
      end

      rule(:nickname) do
        unless NICKNAME_REGEX.match?(value)
          key.failure('is an invalid user name')
        end
      end
    end
  end
end

