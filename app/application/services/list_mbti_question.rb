# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object to obtain mbti question from gateway api
    class ListMBTIQuestion
      include Dry::Transaction

      step :call_api
      step :reify_mbti_question

      def call_api(question_id)
        Gateway::Api.new(TravellingSuggestions::App.config)
                    .list_mbti_question(question_id)
                    .then do |result|
          result.success? ? Success(result.payload) : Failure(result.message)
        end
      rescue StandardError
        Failure('could not access out API for mbti question')
      end

      def reify_mbti_question(input)
        TravellingSuggestions::Representer::MBTIQuestion.new(OpenStruct.new)
                                                        .from_json(input)
                                                        .then { |mbti_question| Success(mbti_question) }
      rescue StandardError
        Failure('Error in listing mbti questions, please try again')
      end
    end
  end
end
