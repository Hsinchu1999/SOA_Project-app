# frozen_string_literal: true

require 'http'
require_relative 'location'

module TravellingSuggestions
  # Library for Github Web API
  class CWBApi

    module Errors
      class NotFound < StandardError; end
      class Unauthorized < StandardError; end
    end

    HTTP_ERROR = {
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }.freeze

    def initialize(token)
      @cwb_token = token
    end

    def location(location)
      data = call_cwb_url('F-C0032-001').parse
      Location.new(location, data)
    end

    private

    def call_cwb_url(functionality)
      result =
        HTTP.get("https://opendata.cwb.gov.tw/api/v1/rest/datastore/#{functionality}?Authorization=#{@cwb_token}")
      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end