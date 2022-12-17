# frozen_string_literal: true

module Views
  # A Views object for a MBTI result open struct
  class MBTIResult
    def initialize(mbti_result)
      @mbti_result = mbti_result
    end

    def personalities
      @mbti_result.personalities
    end
  end
end
