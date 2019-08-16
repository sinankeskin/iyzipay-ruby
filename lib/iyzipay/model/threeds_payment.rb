# frozen_string_literal: true

module Iyzipay
  module Model
    class ThreedsPayment < IyzipayResource
      def create(request = {}, options)
        pki_string = to_pki_string_create(request)
        HttpClient.post("#{options.base_url}/payment/iyzipos/auth3ds/ecom",
                        http_headers(pki_string, options).merge(body: request.to_json))
      end

      def retrieve(request = {}, options)
        pki_string = to_pki_string_retrieve(request)
        HttpClient.post("#{options.base_url}/payment/detail",
                        http_headers(pki_string, options).merge(body: request.to_json))
      end

      def to_pki_string_create(request)
        PkiBuilder.new
                  .append(:locale, request[:locale])
                  .append(:conversationId, request[:conversationId])
                  .append(:paymentId, request[:paymentId])
                  .append(:conversationData, request[:conversationData])
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
