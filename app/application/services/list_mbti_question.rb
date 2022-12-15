# frozen_string_literal: true

require 'dry/monads'

module TravellingSuggestions
  module Service
    # A Service object to validate Entity::Weather object from db
    class ListMBTIQuestion
      include Dry::Transaction

      step :call
      step :reify_mbti_question

      def call(question_id)
        mbti_question = Gateway::Api.new(TravellingSuggestions::App.config).list_mbti_question(question_id)
        Success(
          Response::ApiResult.new(
            status: :ok,
            message: mbti_question
          )
        )
      rescue StandardError
        Failure(
          Response::ApiResult.new(
            status: :not_found,
            message: 'Could not fetch mbti question from database'
          )
        )
      end

      def reify_mbti_question(input)
        TravellingSuggestions::Representer::MBTIQuestion.new(OpenStruct.new)
          .from_json(input)
          .then{ |mbti_question| Success(mbti_question) }
      rescue StandardError
        Failure('Error in listing mbti questions, please try again')
      end
    end
  end
end
