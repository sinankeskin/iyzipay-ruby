# frozen_string_literal: true

module Iyzipay
  module Model
    class InstallmentInfo < IyzipayResource
      def retrieve(request = {}, options)
        pki_string = to_pki_string(request)

        params = {
          headers: http_headers(pki_string, options),
          body: request.to_json
        }

        HttpClient.post("#{options.base_url}/payment/iyzipos/installment",
                        params)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super)
                  .append(:binNumber, request[:binNumber])
                  .append_price(:price, request[:price])
                  .get_request_string
      end
    end
  end
end
