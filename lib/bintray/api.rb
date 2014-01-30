require 'httparty'

module Bintray
  class API
    def initialize(endpoint)
      @endpoint = endpoint
    end

    def get(path)
      resp = HTTParty.get("#{@endpoint}#{path}")
      raise Bintray::Error::NotFound, resp.body if resp.not_found?
      return resp.parsed_response
    end
  end
end
