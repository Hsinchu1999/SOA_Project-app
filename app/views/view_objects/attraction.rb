# frozen_string_literal: true

require_relative 'region'

module Views
  # A View object for Entity::Attraction
  class Attraction
    def initialize(attraction)
      @attraction = attraction
    end

    def added_time
      @attraction.added_time
    end

    def attraction_region
      # returns a View object for Entity::Region object
      Views::Region.new(@attraction.region)
    end

    def attraction_indoor_or_outdoor
      @attraction.indoor_or_outdoor.to_s
    end

    def attraction_main_activity
      @attraction.main_activity
    end

    def staying_time
      @attraction.staying_time
    end

    def type
      @attraction.type
    end

    def attendants
      @attraction.attendants.to_s
    end

    def notes
      @attraction.notes
    end

    def contact
      @attraction.contact
    end

    def best_time_to_visit
      @attraction.best_time_to_visit
    end
  end
end
