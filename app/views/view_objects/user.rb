require_relative 'user_favorite'

module Views
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
      # returns a User_Favorite Views object
      Views::User_Favorite.new(@user.favorite_attractions)
    end
  end
end