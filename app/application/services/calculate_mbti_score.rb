# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object to call gateway '/mbti_test/result'
    class CalculateMBTIScore
      include Dry::Transaction

      step :call_api
      step :reify_result

      def call_api(input)
        mbti_question = Gateway::Api.new(TravellingSuggestions::App.config)
          .calculate_mbti_score(input[:question_ids], input[:answers])
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('could not access our API to calculate mbti result')
      end

      def reify_result(input)
        TravellingSuggestions::Representer::MBTIQuestionScore.new(OpenStruct.new)
          .from_json(input)
          .then { |mbti_score| Success(mbti_score) }
      rescue StandardError
        Failure('Error in calculating mbti result, please try again')
      end
    end
  end
end
