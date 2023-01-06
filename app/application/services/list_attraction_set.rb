# frozen_string_literal: true

require 'dry/monads'
require 'json'

module TravellingSuggestions
  module Service
    # A Service object to get a set of attraction from api
    class ListAttractionSet
      include Dry::Transaction

      step :call_api
      step :reify_attraction_set

      def call_api(input)
        set_size = input[:set_size]
        mbti = input[:mbti]
        Gateway::Api.new(TravellingSuggestions::App.config)
                    .list_attraction_set(set_size, mbti)
                    .then do |result|
          result.success? ? Success(result.payload) : Failure(result.message)
        end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_attraction_set(input)
        TravellingSuggestions::Representer::AttractionSet.new(OpenStruct.new)
                                                           .from_json(input)
                                                           .then { |attraction_set| Success(attraction_set) }
      rescue StandardError
        Failure('Error in generating attraction set, please try again')
      end
    end
  end
end
