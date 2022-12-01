module TravellingSuggestions
    module Repository
      class Users_Favorites
        def self.find_user_id(id)
          rebuild_entity Database::UserOrm.first(id: id)
        end
        
        def self.find_user_name(nickname)
          rebuild_entity Database::UserOrm.first(nickname: nickname)
        end
        def self.rebuild_entity(db_record)
          return nil unless db_record
          
          user_favorite_attractions = Repository::Attractions.rebuild_many_entities(db_record.favorite_attractions)

          Entity::UserFavorite.new(
            favorites_list:       user_favorite_attractions,
          )
        end

        def self.rebuild_many_entities(db_records)
          db_records.map do | db_member |
            Users_Favorites.rebuild_entity(db_member)
          end
        end

        def self.db_find_or_create(entity)
          nil
        end
        # to be completed

      end
    end
  end