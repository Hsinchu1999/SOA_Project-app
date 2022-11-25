# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:MBTI_questions) do
      primary_key :id

      String :question
      String :answerA
      String :answerB
      String :section
      String :directionA
      Integer :scoreA
      Integer :scoreB

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
