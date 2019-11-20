# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'builder'

RSpec.describe 'Iyzipay' do
  before :all do
    @options = Iyzipay::Options.new
    @options.api_key = SpecOptions::API_KEY
    @options.secret_key = SpecOptions::SECRET_KEY
    @options.base_url = SpecOptions::BASE_URL
  end

  it 'should refund to balance' do
    # create payment
    payment = Builder::PaymentBuilder.new.create_standard_listing_payment(@options)
    request = {
      locale: Iyzipay::Model::Locale::TR,
      conversationId: '123456789',
      paymentId: payment['paymentId'],
      callbackUrl: 'https://merchanturl.com'
    }
    refund_to_balance = Iyzipay::Model::RefundToBalance.new.create(request, @options)
    begin
      $stdout.puts refund_to_balance.inspect
      expect(refund_to_balance['status']).not_to be_nil
      expect(refund_to_balance['token']).not_to be_nil
      expect(refund_to_balance['url']).not_to be_nil
    rescue StandardError
      warn 'oops'
      raise
    end
  end

  after :each do
  end
end
