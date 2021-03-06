# frozen_string_literal: true

require_relative '../spec_helper'

module Builder
  class ApprovalBuilder
    def create_approval(options, payment_transaction_id)
      request = {
        locale: Iyzipay::Model::Locale::TR,
        conversationId: '123456789',
        paymentTransactionId: payment_transaction_id
      }

      Iyzipay::Model::Approval.new.create(request, options)
    end
  end
end
