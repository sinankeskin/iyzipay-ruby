# frozen_string_literal: true

module Iyzipay
  module Model
    class BasicBkmInitialize < IyzipayResource
      def create(request = {}, options)
        pki_string = to_pki_string(request)
        HttpClient.post("#{options.base_url}/payment/iyziconnect/bkm/initialize",
                        http_headers(pki_string, options).merge(body: request.to_json))
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super)
                  .append(:connectorName, request[:connectorName])
                  .append_price(:price, request[:price])
                  .append(:callbackUrl, request[:callbackUrl])
                  .append(:buyerEmail, request[:buyerEmail])
                  .append(:buyerId, request[:buyerId])
                  .append(:buyerIp, request[:buyerIp])
                  .append(:posOrderId, request[:posOrderId])
                  .append_array(:installmentDetails, InstallmentDetails.to_pki_string(request[:installmentDetails]))
                  .get_request_string
      end
    end
  end
end
