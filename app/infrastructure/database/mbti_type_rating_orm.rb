# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class MBTITypeRatingOrm < Sequel::Model(:mbti_type_ratings)
      plugin :timestamps, update_on_create: true
    end
  end
end
