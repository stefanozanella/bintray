require 'bintray/repository'
require 'httparty'

module Bintray
  class Client
    def initialize(params)
      @params = params
    end

    def repo(name)
      resp = HTTParty.get("#{@params[:endpoint]}/repos/#{@params[:user]}/#{name}", :format => :plain)
      raise Bintray::Error::NotFound, resp.body if resp.not_found?
      return Repository.new API.new(@params[:endpoint]), JSON.parse(resp.body)
    end
  end
end
