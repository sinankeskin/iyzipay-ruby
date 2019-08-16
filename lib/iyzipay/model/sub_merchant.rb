# frozen_string_literal: true

module Iyzipay
  module Model
    class SubMerchant < IyzipayResource
      def create(request = {}, options)
        pki_string = to_pki_string_create(request)
        HttpClient.post("#{options.base_url}/onboarding/submerchant",
                        params)
      end

      def update(request = {}, options)
        pki_string = to_pki_string_update(request)
        HttpClient.put("#{options.base_url}/onboarding/submerchant",
                       params)
      end

      def retrieve(request = {}, options)
        pki_string = to_pki_string_retrieve(request)
        HttpClient.post("#{options.base_url}/onboarding/submerchant/detail",
                        params)
      end

      def to_pki_string_create(request)
        PkiBuilder.new
                  .append(:locale, request[:locale])
                  .append(:conversationId, request[:conversationId])
                  .append(:name, request[:name])
                  .append(:email, request[:email])
                  .append(:gsmNumber, request[:gsmNumber])
                  .append(:address, request[:address])
                  .append(:iban, request[:iban])
                  .append(:taxOffice, request[:taxOffice])
                  .append(:contactName, request[:contactName])
                  .append(:contactSurname, request[:contactSurname])
                  .append(:legalCompanyTitle, request[:legalCompanyTitle])
                  .append(:swiftCode, request[:swiftCode])
                  .append(:currency, request[:currency])
                  .append(:subMerchantExternalId, request[:subMerchantExternalId])
                  .append(:identityNumber, request[:identityNumber])
                  .append(:taxNumber, request[:taxNumber])
                  .append(:subMerchantType, request[:subMerchantType])
                  .get_request_string
      end

      def to_pki_string_update(request)
        PkiBuilder.new
                  .append(:locale, request[:locale])
                  .append(:conversationId, request[:conversationId])
                  .append(:name, request[:name])
                  .append(:email, request[:email])
                  .append(:gsmNumber, request[:gsmNumber])
                  .append(:address, request[:address])
                  .append(:iban, request[:iban])
                  .append(:taxOffice, request[:taxOffice])
                  .append(:contactName, request[:contactName])
                  .append(:contactSurname, request[:contactSurname])
                  .append(:legalCompanyTitle, request[:legalCompanyTitle])
                  .append(:swiftCode, request[:swiftCode])
                  .append(:currency, request[:currency])
                  .append(:subMerchantKey, request[:subMerchantKey])
                  .append(:identityNumber, request[:identityNumber])
                  .append(:taxNumber, request[:taxNumber])
                  .get_request_string
      end

      def to_pki_string_retrieve(request)
        PkiBuilder.new
                  .append(:locale, request[:locale])
                  .append(:conversationId, request[:conversationId])
                  .append(:subMerchantExternalId, request[:subMerchantExternalId])
                  .get_request_string
      end
    end
  end
end
