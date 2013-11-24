require 'httparty'

module Bintray
  class Client
    def initialize(opts)
      @opts = opts
    end

    def create_package(package, license, repo)
      resp = HTTParty.post("#{@opts[:endpoint]}/packages/#{@opts[:user]}/#{repo}",
        { :body => { :name => package, :licenses => [ license ] }.to_json,
          :headers => { 'Content-Type' => 'application/json' },
          :basic_auth => { :username => @opts[:user], :password => @opts[:key] } })

      Package.from_hash resp
    end
  end
end
