# frozen_string_literal: true

require 'http'

module TravellingSuggestions
  module Gateway
    # Infrastructure to call TravellingSuggestions API
    class Api
      def initialize(config)
        @config = config
        @request = Request.new(@config)
      end

      def alive?
        @request.get_root.success?
      end

      def add_user(nickname, mbti_type)
        @request.add_user(nickname, mbti_type)
      end
      def list_user(nickname)
        @request.list_user(nickname)
      end
      def list_mbti_question(question_id)
        @request.list_mbti_question(question_id)
      end
      def submit_login(nickname)
        @request.submit_login(nickname)
      end
      # HTTP request transmitter
      class Request
        def initialize(config)
          @api_host = config.API_HOST
          @api_root = config.API_HOST + '/api/v1'
        end

        def get_root
          call_api_get()
        end

        def add_user(nickname, mbti_type)
          params = {'nickname'=> nickname, 'mbti'=> mbti_type}
          call_api_post(['user', 'construct_profile'], params)
        end

        def list_user(nickname)
          params = {'nickname'=> nickname}
          call_api('get', ['user'], params)
        end

        def list_mbti_question(question_id)
          params = {'question_id'=> question_id.to_s}
          call_api_get(['mbti_test', 'question'], params)
        end

        def submit_login(nickname)
          params = {'nickname'=> nickname}
          call_api('post', ['user', 'submit_login'], params)
        end
        private
        # def call_api(method, resources = [], params = {})
        #   api_path = resources.empty? ? @api_host : @api_root
        #   url = [api_path, resources].flatten.join('/')
        #   # puts url
        #   unless params.empty?
        #     url += '?'
        #     params.each do |key, value|
        #       url += key + '=' + value + '&'
        #     end
        #     url = url[0..-1]
        #   end
        #   puts 'before HTTP call'
        #   puts url
        #   HTTP.header('Accept' => 'application/json').send(method, url)
        #     .then { |http_response| Response.new(http_response) }
        # rescue StandardError
        #   raise "Invalid URL request: #{url}"
        # end

        def call_api_get(resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/')
          unless params.empty?
            url += '?'
            params.each do |key, value|
              url += key + '=' + value + '&'
            end
          end
          url = url.delete_suffix('&')
          HTTP.get(url).then { |http_response| Response.new(http_response) }
        rescue
          puts "HTTP request failed, url = #{url}"
        end

        def call_api_post(resources = [], params = {})
          api_path = resources.empty? ? @api_host : @api_root
          url = [api_path, resources].flatten.join('/')
          unless params.empty?
            url += '?'
            params.each do |key, value|
              url += key + '=' + value + '&'
            end
          end
          url = url.delete_suffix('&')
          HTTP.post(url).then { |http_response| Response.new(http_response) }
        rescue
          puts "HTTP request failed, url = #{url}"
        end

        # Decorates HTTP responses with success/error
        class Response < SimpleDelegator
          NotFound = Class.new(StandardError)

          SUCCESS_CODES = (200..299).freeze
          CONFLICT_CODE = 409

          def success?
            code.between?(SUCCESS_CODES.first, SUCCESS_CODES.last)
          end

          def conflict?
            code == CONFLICT_CODE
          end

          def message
            payload['message']
          end

          def payload
            body.to_s
          end
        end
      end
    end
  end
end
