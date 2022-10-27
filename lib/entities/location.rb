require 'dry-types'
require 'dry-struct'

module CodePraise
  module Entity
    class Location < Dry::struct
      include Dry.types

      attribute :prob_rain,        types::Integer
      attribute :min_temperature,  types::Integer
      attribute :max_temperature,  types::Integer
    end
  end
end
