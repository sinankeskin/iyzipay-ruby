# frozen_string_literal: true

module Iyzipay
  module Model
    class PeccoPayment < IyzipayResource
      def create(request = {}, options)
        pki_string = to_pki_string(request)

        params = {
          headers: http_headers(pki_string, options),
          body: request.to_json
        }

        HttpClient.post("#{options.base_url}/payment/pecco/auth",
                        params)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super)
                  .append(:token, request[:token])
                  .get_request_string
      end
    end
  end
end
