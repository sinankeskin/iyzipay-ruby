# frozen_string_literal: true

module Iyzipay
  module Model
    class SettlementToBalance < IyzipayResource
      def create(request = {}, options)
        pki_string = to_pki_string(request)

        params = {
          headers: http_headers(pki_string, options),
          body: request.to_json
        }

        HttpClient.post(
          "#{options.base_url}/payment/settlement-to-balance/init",
          params
        )
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super)
                  .append(:subMerchantKey, request[:subMerchantKey])
                  .append(:callbackUrl, request[:callbackUrl])
                  .append_price(:price, request[:price])
                  .get_request_string
      end
    end
  end
end
