# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class UserActiveRatingOrm < Sequel::Model(:user_active_ratings)
      plugin :timestamps, update_on_create: true
    end
  end
end
