# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../../require_app'
require_app

MBTI_QUESTION_ID = Array(1..10)
MBTI_QUESTION_SET_SIZE = Array(1..11)
VALID_MBTI_QUESTION_PAIR = [
  [%w[1 2 3 4], %w[A B A B]],
  [%w[9 10 11 14], %w[B A A A]]
].freeze
CORRECT_MBTI_QUESTION_RESULT = %w[ENTJ ISFJ].freeze
INVALID_MBTI_QUESTION_PAIR = ['0=A&1=A&2=A&3=A', '99=A&1=A&3=A&4=A'].freeze
VALID_NICKNAMES = %w[peter Peter Peter_ _PETER _ PETERCHEN peter_chen peterchen999].freeze
INVALID_NICKNAMES = ['.', '', './'].freeze

CASSETTE_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'cwb_api'
