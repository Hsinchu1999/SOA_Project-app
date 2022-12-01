# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    # A Repository object for Entity::UserActiveRatings
    class UserActiveRatings
      def self.find_id(id)
        rebuild_entity Database::UserActiveRatingOrm.first(id:)
      end

      def self.rebuild_entity(db_record)
        return nil unless db_record

        user_entity = Repository::Users.find_id(db_record.user_id)
        attraction_entity = Repository::Attractions.find_id(db_record.attraction_id)

        Entity::UserActiveRating.new(
          user: user_entity,
          attraction: attraction_entity,
          score: db_record.score
        )
      end

      def self.rebuild_many_entities(db_records)
        db_records.map do |db_member|
          UserActiveRatings.rebuild_entity(db_member)
        end
      end

      def self.db_find_or_create(_entity)
        nil
      end
      # to be completed
    end
  end
end
