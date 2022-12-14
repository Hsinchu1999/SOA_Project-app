# frozen_string_literal: true

require_relative 'helpers/api_helper'
require_relative 'helpers/vcr_helper'

describe 'Tests CWB API library' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_cwb
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

  # end
  describe 'mbti tests' do
    it 'should return mbti questions' do
      MBTI_QUESTION_ID.each do |question_id|
        question = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).list_mbti_question(question_id)

        _(question.success?).must_equal true
      end
    end
  end

  describe 'Add user name' do
    it 'should allow creating valid user nicknames' do
      VALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).add_user(nickname, 'ENFJ')

        unless result.success?
          _(result.conflict?).must_equal true
        end
      end
    end
    it 'should deny creating invalid user nicknames' do
      INVALID_NICKNAMES.each do |nickname|
        result = TravellingSuggestions::Gateway::Api.new(TravellingSuggestions::App.config).add_user(nickname, 'ENFJ')

        _(result.success?).must_equal false
      end
    end
  end
end
