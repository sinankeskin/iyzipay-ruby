# frozen_string_literal: true

module Iyzipay
  module Model
    class CardList < IyzipayResource
      def retrieve(request = {}, options)
        pki_string = to_pki_string(request)
        HttpClient.post("#{options.base_url}/cardstorage/cards",
                        http_headers(pki_string, options).merge(body: request.to_json))
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super)
                  .append(:cardUserKey, request[:cardUserKey])
                  .get_request_string
      end
    end
  end
end
