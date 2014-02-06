require 'httparty'

module Bintray
  class API
    def initialize(endpoint, user = nil, key = nil)
      @endpoint = endpoint
      @user = user
      @key = key
    end

    def get(path)
      resp = HTTParty.get("#{@endpoint}#{path}", authenticated)
      raise Bintray::Error::NotFound, resp.body if resp.not_found?
      resp.parsed_response
    end

    def post(path, data)
      resp = HTTParty.post("#{@endpoint}#{path}", authenticated(request_body_for(data)))
      resp.parsed_response
    end

    def put(path, data)
      resp = HTTParty.put("#{@endpoint}#{path}", authenticated(request_body_for(data)))
      resp.parsed_response
    end

    def delete(path)
      HTTParty.delete("#{@endpoint}#{path}", authenticated)
    end

    private

    def request_body_for(data)
      {:body => data.to_json, :headers => { 'Content-Type' => 'application/json' }}
    end

    def authenticated(data = {})
      data.merge(auth_options)
    end

    def auth_options
      has_auth? ? {:basic_auth => { :username => @user, :password => @key }} : {}
    end

    def has_auth?
      @user && @key
    end
  end
end
