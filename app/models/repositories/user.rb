module TravellingSuggestions
    module Repository
      class Users
        def self.find_id(id)
          rebuild_entity Database::UserOrm.first(id: id)
        end
        
        def self.find_name(nickname)
          rebuild_entity Database::UserOrm.first(nickname: nickname)
        end
        def self.rebuild_entity(db_record)
          return nil unless db_record
          
          user_favorite_attractions = Repository::Users_Favorites.rebuild_entity(db_record)

          Entity::User.new(
            id:       db_record.id,
            nickname:   db_record.nickname,
            mbti:   db_record.mbti,
            favorite_attractions: user_favorite_attractions
          )
        end

        def self.rebuild_many_entities(db_records)
          db_records.map do | db_member |
            Users.rebuild_entity(db_member)
          end
        end

        def self.db_find_or_create(entity)
          nil
        end
        # to be completed

      end
    end
  end