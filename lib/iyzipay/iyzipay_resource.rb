# frozen_string_literal: true

module Iyzipay
  class IyzipayResource
    AUTHORIZATION_HEADER_NAME = 'Authorization'
    RANDOM_HEADER_NAME = 'x-iyzi-rnd'
    AUTHORIZATION_HEADER_STRING = 'IYZWS %s:%s'
    RANDOM_STRING_SIZE = 8
    RANDOM_CHARS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'

    def http_headers(pki_string = nil, options = nil, authorize_request = true)
      headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }

      return headers unless authorize_request

      random_header_value = random_string(RANDOM_STRING_SIZE)

      headers[AUTHORIZATION_HEADER_NAME] = prepare_authorization_string(
        pki_string,
        random_header_value,
        options
      )

      headers[RANDOM_HEADER_NAME] = random_header_value

      headers
    end

    def plain_http_headers
      http_headers(nil, false)
    end

    def prepare_authorization_string(pki_string, random_header_value, options)
      hash_digest = calculate_hash(pki_string, random_header_value, options)

      format_header_string(options.api_key, hash_digest)
    end

    def json_decode(response, raw_result)
      json_result = JSON.parse(raw_result)

      response.from_json(json_result)
    end

    def calculate_hash(pki_string, random_header_value, options)
      Digest::SHA1.base64digest("#{options.api_key}#{random_header_value}#{options.secret_key}#{pki_string}")
    end

    def format_header_string(*args)
      format(AUTHORIZATION_HEADER_STRING, *args)
    end

    def random_string(string_length)
      random_string = +''

      string_length.times do
        random_string << RANDOM_CHARS.split('').sample
      end

      random_string
    end

    def to_pki_string(request)
      PkiBuilder.new.append(:locale, request[:locale])
                .append(:conversationId, request[:conversationId])
                .get_request_string
    end
  end
end
