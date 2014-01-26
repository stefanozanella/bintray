require 'httparty'

module Bintray
  class API
    def initialize(endpoint)
      @endpoint = endpoint
    end

    def get(path)
      HTTParty.get("#{@endpoint}#{path}").parsed_response
    end
  end
end
