# frozen_string_literal: true

require 'dry/monads'
require 'json'

module TravellingSuggestions
  module Service
    # A Service object to get a set of mbti questions from api
    class ListMBTIQuestionSet
      include Dry::Transaction

      step :call_api
      step :reify_mbti_question_set

      def call_api(set_size)
        mbti_question_set = Gateway::Api.new(TravellingSuggestions::App.config).
          list_mbti_question_set(set_size)
          .then do |result|
            result.success? ? Success(result.payload) : Failure(result.message)
          end
      rescue StandardError
        Failure('Could not access our API')
      end

      def reify_mbti_question_set(input)
        puts 'in reify_mbti_question_set'
        puts input
        puts input.class
        TravellingSuggestions::Representer::MBTIQuestionSet.new(OpenStruct.new)
          .from_json(input)
          .then { |question_set| Success(question_set)}
      rescue StandardError
        Failure('Error in generating mbti question set, please try again')
      end
    end
  end
end
