# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class MBTIMainActivityRatingOrm < Sequel::Model(:mbti_mainactivity_ratings)
      plugin :timestamps, update_on_create: true
    end
  end
end
