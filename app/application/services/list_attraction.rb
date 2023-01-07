# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object to obtain attraction from gateway api
    class ListAttraction
      include Dry::Transaction

      step :call_api
      step :reify_attraction

      def call_api(attraction_id)
        Gateway::Api.new(TravellingSuggestions::App.config)
                    .list_attraction(attraction_id)
                    .then do |result|
          result.success? ? Success(result.payload) : Failure(result.message)
        end
      rescue StandardError
        Failure('could not access our API for attraction')
      end

      def reify_attraction(input)
        TravellingSuggestions::Representer::Attraction.new(OpenStruct.new)
                                                        .from_json(input)
                                                        .then { |attraction| Success(attraction) }
      rescue StandardError
        Failure('Error in fetching attraction, please try again')
      end
    end
  end
end
