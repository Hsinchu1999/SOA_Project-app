# frozen_string_literal: true

module Views
  # A Views object for a MBTI question open struct
  class MBTIQuestion
    def initialize(mbti_question)
      @mbti_question = mbti_question
    end

    def id
      @mbti_question.id
    end

    def question
      @mbti_question.question
    end

    def answerA
      @mbti_question.answerA
    end

    def answerB
      @mbti_question.answerB
    end

    def section
      @mbti_question.section
    end

    def directionA
      @mbti_question.directionA
    end

    def scoreA
      @mbti_question.scoreA
    end

    def scoreB
      @mbti_question.scoreB
    end
  end
end
