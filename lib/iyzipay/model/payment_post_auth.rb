# frozen_string_literal: true

module Iyzipay
  module Model
    class PaymentPostAuth < IyzipayResource
      def create(request = {}, options)
        pki_string = to_pki_string(request)

        params = {
          headers: http_headers(pki_string, options),
          body: request.to_json
        }

        HttpClient.post("#{options.base_url}/payment/iyzipos/postauth",
                        params)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super)
                  .append(:paymentId, request[:paymentId])
                  .append(:ip, request[:ip])
                  .append_price(:paidPrice, request[:paidPrice])
                  .append(:currency, request[:currency])
                  .get_request_string
      end
    end
  end
end
