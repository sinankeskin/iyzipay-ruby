# frozen_string_literal: true

module Iyzipay
  module Model
    class PaymentPreAuth < IyzipayResource
      def create(request = {}, options)
        pki_string = to_pki_string_create(request)

        params = {
          headers: http_headers(pki_string, options),
          body: request.to_json
        }

        HttpClient.post("#{options.base_url}/payment/iyzipos/preauth/ecom",
                        params)
      end

      def retrieve(request = {}, options)
        pki_string = to_pki_string_retrieve(request)

        params = {
          headers: http_headers(pki_string, options),
          body: request.to_json
        }

        HttpClient.post("#{options.base_url}/payment/detail",
                        params)
      end

      def to_pki_string_create(request)
        PkiBuilder.new
                  .append(:locale, request[:locale])
                  .append(:conversationId, request[:conversationId])
                  .append_price(:price, request[:price])
                  .append_price(:paidPrice, request[:paidPrice])
                  .append(:installment, request[:installment])
                  .append(:paymentChannel, request[:paymentChannel])
                  .append(:basketId, request[:basketId])
                  .append(:paymentGroup, request[:paymentGroup])
                  .append(:paymentCard, PaymentCard.to_pki_string(request[:paymentCard]))
                  .append(:buyer, Buyer.to_pki_string(request[:buyer]))
                  .append(:shippingAddress, Address.to_pki_string(request[:shippingAddress]))
                  .append(:billingAddress, Address.to_pki_string(request[:billingAddress]))
                  .append_array(:basketItems, Basket.to_pki_string(request[:basketItems]))
                  .append(:paymentSource, request[:paymentSource])
                  .append(:currency, request[:currency])
                  .append(:posOrderId, request[:posOrderId])
                  .append(:connectorName, request[:connectorName])
                  .get_request_string
      end

      def to_pki_string_retrieve(request)
        PkiBuilder.new
                  .append(:locale, request[:locale])
                  .append(:conversationId, request[:conversationId])
                  .append(:paymentId, request[:paymentId])
                  .append(:paymentConversationId, request[:paymentConversationId])
                  .get_request_string
      end
    end
  end
end
