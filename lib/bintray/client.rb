require 'bintray/repository'
require 'httparty'

module Bintray
  class Client
    def initialize(params)
      @params = params
    end

    def repo(name)
      resp = HTTParty.get("#{@params[:endpoint]}/repos/#{@params[:user]}/#{name}")
      return Repository.new API.new(@params[:endpoint]), resp.parsed_response
    end
  end
end
