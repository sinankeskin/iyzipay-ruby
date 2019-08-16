# frozen_string_literal: true

module Iyzipay
  class HttpClient
    def self.get(path, options = {}, &block)
      HTTParty.get(path, options, &block)
    end

    def self.post(path, options = {}, &block)
      HTTParty.post(path, options, &block)
    end

    def self.put(path, options = {}, &block)
      HTTParty.put(path, options, &block)
    end

    def self.delete(path, options = {}, &block)
      HTTParty.delete(path, options, &block)
    end
  end
end
