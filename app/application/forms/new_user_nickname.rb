# frozen_string_literal: true

require 'dry-validation'

module TravellingSuggestions
  module Forms
    # A Form object to validate user's nickname input
    class NewUserNickname < Dry::Validation::Contract
      params do
        required(:nickname).filled(:string)
      end

      rule(:nickname) do
        key.failure('is an invalid user name') unless value.count('^a-zA-Z0-9_').zero?
        key.failure('is an invalid user name') unless value.length.positive?
      end
    end
  end
end
