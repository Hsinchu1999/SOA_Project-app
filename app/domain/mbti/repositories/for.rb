# frozen_string_literal: true

require_relative 'mbti_question'

module TravellingSuggestions
  module Repository
    # A For module for MBTI
    module ForMBTI
      ENTITY_REPOSITORY = {
        Entity::MBTIQuestion => MBTIQuestions
      }.freeze

      def self.klass(entity_klass)
        ENTITY_REPOSITORY[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_REPOSITORY[entity_object.class]
      end
    end
  end
end
