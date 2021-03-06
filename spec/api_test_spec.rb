# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Iyzipay' do
  before :all do
    @options = Iyzipay::Options.new
    @options.api_key = SpecOptions::API_KEY
    @options.secret_key = SpecOptions::SECRET_KEY
    @options.base_url = SpecOptions::BASE_URL
  end

  it 'should test api' do
    api_test = Iyzipay::Model::ApiTest.new.retrieve(@options)
    begin
      expect(api_test['status']).to eq('success')
      expect(api_test['locale']).to eq('tr')
      expect(api_test['systemTime']).not_to be_nil
    rescue StandardError
      warn 'oops'
      raise
    end
  end

  after :each do
  end
end
