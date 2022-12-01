# frozen_string_literal: true

require 'dry-validation'

module TravellingSuggestions
  module Forms
    # A Form object to validate user's nickname input
    class NewUserNickname < Dry::Validation::Contract
      NICKNAME_REGEX = %r{/^\w+$/}

      params do
        required(:nickname).filled(:string)
      end

      rule(:nickname) do
        key.failure('is an invalid user name') unless NICKNAME_REGEX.match?(value)
      end
    end
  end
end
