# frozen_string_literal: true

require_relative 'user_favorite'

module Views
  # A Views object for Entity::User
  class User
    def initialize(user)
      @user = user
    end

    def id
      @user.id.to_s
    end

    def nickname
      @user.nickname
    end

    def mbti
      @user.mbti
    end

    def favorite_attractions
      # returns a UserFavorite Views object
      # Views::UserFavorite.new(@user.favorite_attractions)
    end
  end
end
