# frozen_string_literal: true

module TravellingSuggestions
  module Repository
    class User_Active_Ratings
      def self.find_id(id)
        rebuild_entity Database::UserActiveRatingOrm.first(id: id)
      end
      
      def self.rebuild_entity(db_record)
        return nil unless db_record
        
        user_entity = Repository::Users.find_id(db_record.user_id)
        attraction_entity = Repository::Attractions.find_id(db_record.attraction_id)

        Entity::User_Active_Rating.new(
          user:       user_entity,
          attraction:   attraction_entity,
          score:   db_record.score
        )
      end

      def self.rebuild_many_entities(db_records)
        db_records.map do | db_member |
          User_Active_Ratings.rebuild_entity(db_member)
        end
      end

      def self.db_find_or_create(entity)
        nil
      end
      # to be completed

    end
  end
end