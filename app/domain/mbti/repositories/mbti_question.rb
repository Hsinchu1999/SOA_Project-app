# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    # A Repository for Entity::MBTIQuestion object
    class MBTIQuestions
      def self.find_id(id)
        rebuild_entity Database::MBTIQuestionOrm.first(id:)
      end

      def self.find_tier(tier)
        rebuild_many_entities Database::MBTIQuestionOrm.where(tier:).all
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::MBTIQuestions.new(
          id: db_record.id,
          text: db_record.text,
          section: db_record.section,
          direction: db_record.direction,
          tier: db_record.tier
        )
      end

      def self.rebuild_many_entities(db_records)
        db_records.map do |db_member|
          MBTIQuestions.rebuild_entity(db_member)
        end
      end

      def self.db_find_or_create(_entity)
        nil
      end
      # to be completed
    end
  end
end
