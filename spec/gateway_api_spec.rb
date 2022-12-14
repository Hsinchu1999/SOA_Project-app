# frozen_string_literal: true

require_relative 'helpers/api_helper'
require_relative 'helpers/vcr_helper'

require 'json'

describe 'Tests CWB API library' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_api
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Check API alive' do
    it 'should check api alive' do
      alive = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).alive?
      _(alive).must_equal true
    end
  end

  describe 'Get single mbti question by id' do
    it 'should return mbti questions' do
      MBTI_QUESTION_ID.each do |question_id|
        question = TravellingSuggestions::Gateway::Api
                   .new(TravellingSuggestions::App.config)
                   .list_mbti_question(question_id)

        _(question.success?).must_equal true
      end
    end
  end

  describe 'Get mbti question id set' do
    it 'should return a set of mbti question ids' do
      MBTI_QUESTION_SET_SIZE.each do |set_size|
        question_set = TravellingSuggestions::Gateway::Api.new(
          TravellingSuggestions::App.config
        ).list_mbti_question_set(set_size)

        _(question_set.success?).must_equal true
      end
    end
  end

  describe 'Get mbti test result' do
    it 'should get correct test result' do
      VALID_MBTI_QUESTION_PAIR.each_with_index do |question_pair, index|
        result = TravellingSuggestions::Gateway::Api.new(
          TravellingSuggestions::App.config
        ).calculate_mbti_score(question_pair[0], question_pair[1])

        _(result.success?).must_equal true

        mbti_type = JSON.parse(result.payload)['personalities']
        _(mbti_type).must_equal CORRECT_MBTI_QUESTION_RESULT[index]
      end
    end
  end

  describe 'Add user name' do
    it 'should allow creating valid user nicknames' do
      VALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).add_user(nickname, 'ENFJ')

        _(result.conflict?).must_equal true unless result.success?
      end
    end
    it 'should deny creating invalid user nicknames' do
      INVALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).add_user(nickname, 'ENFJ')

        _(result.success?).must_equal false
      end
    end
  end

  describe 'List user' do
    it 'should allow creating valid user nicknames' do
      VALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).add_user(nickname, 'ENFJ')

        _(result.conflict?).must_equal true unless result.success?
      end
    end

    it 'should list created users' do
      VALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).list_user(nickname)

        _(result.success?).must_equal true
      end
    end
  end

  describe 'Submit login' do
    it 'should allow creating valid user nicknames' do
      VALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).add_user(nickname, 'ENFJ')

        _(result.conflict?).must_equal true unless result.success?
      end
    end

    it 'should allow eligible users login' do
      VALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).submit_login(nickname)

        _(result.success?).must_equal true
      end
    end

    it 'should deny ineligible users login' do
      INVALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).submit_login(nickname)

        _(result.not_found?).must_equal true
      end
    end
  end
end
