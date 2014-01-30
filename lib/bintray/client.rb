require 'bintray/repository'

module Bintray
  class Client
    def initialize(params)
      @params = params
      @api = API.new(@params[:endpoint],
                     @params[:user],
                     @params[:key])
    end

    def repo?(name)
      repo(name)
      true
    rescue Error::NotFound
      false
    end

    def repo(name)
      Repository.new @api, @api.get("/repos/#{@params[:user]}/#{name}")
    end
  end
end
