# frozen_string_literal: true

require 'sequel'

module TravellingSuggestions
  module Database
    class MBTIInOutdoorRatingOrm < Sequel::Model(:mbti_inoutdoor_ratings)
      
      plugin :timestamps, update_on_create: true
    end
  end
end
