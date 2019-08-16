# frozen_string_literal: true

module Iyzipay
  module Model
    class BasicThreedsInitializePreAuth < IyzipayResource
      def create(request = {}, options)
        pki_string = to_pki_string(request)

        params = {
          headers: http_headers(pki_string, options),
          body: request.to_json
        }

        HttpClient.post("#{options.base_url}/payment/iyziconnect/initialize3ds/preauth",
                        params)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super)
                  .append_price(:price, request[:price])
                  .append_price(:paidPrice, request[:paidPrice])
                  .append(:installment, request[:installment])
                  .append(:buyerEmail, request[:buyerEmail])
                  .append(:buyerId, request[:buyerId])
                  .append(:buyerIp, request[:buyerIp])
                  .append(:posOrderId, request[:posOrderId])
                  .append(:paymentCard, PaymentCard.to_pki_string(request[:paymentCard]))
                  .append(:currency, request[:currency])
                  .append(:connectorName, request[:connectorName])
                  .append(:callbackUrl, request[:callbackUrl])
                  .get_request_string
      end
    end
  end
end
