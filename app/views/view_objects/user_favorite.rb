# frozen_string_literal: true

require_relative 'attraction'

module Views
  # A Views object for Entity::UserFavorite
  class UserFavorite
    def initialize(user_favorite)
      @user_favorite = user_favorite
    end

    def show_all
      # returns a list of Views::Attraction objects
      @user_favorite.retrieve_all.map do |attraction_obj|
        Views::Attraction.new(attraction_obj)
      end
    end
  end
end
