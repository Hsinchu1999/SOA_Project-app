# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class MBTIOrm < Sequel::Model(:MBTI_questions)
      
      plugin :timestamps,update_on_create: true
    end
  end
end