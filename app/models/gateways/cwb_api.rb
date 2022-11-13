# frozen_string_literal: true

require 'http'

module TravellingSuggestions
  # Library for Github Web API
  module CWB
    class CWBApi
      def initialize(token)
        @cwb_token = token
      end

      def location_data(location)
        data = call_cwb_url('F-C0032-001').parse['records']['location'].select { |data| data['locationName'] == location }
      end

      private

      def call_cwb_url(functionality)
        result =
            HTTP.get("https://opendata.cwb.gov.tw/api/v1/rest/datastore/#{functionality}?Authorization=#{@cwb_token}")

        Response.new(result).tap do |response|
            raise(response.error) unless response.successful?
        end
      end

      # API response message
      class Response < SimpleDelegator
        module Errors
            # 404 error
            class NotFound < StandardError; end
            # 401 error
            class Unauthorized < StandardError; end
        end

        HTTP_ERROR = {
            401 => Errors::Unauthorized,
            404 => Errors::NotFound
        }.freeze

        def successful?
            !HTTP_ERROR.keys.include?(code)
        end

        def error
            HTTP_ERROR[code]
        end
      end
    end
  end
end
