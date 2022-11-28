# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class MBTIStayingtimeRatingOrm < Sequel::Model(:mbti_stayingtime_ratings)
      plugin :timestamps, update_on_create: true
    end
  end
end
