require 'minitest/autorun'
require 'minitest/spec'
require 'mocha/setup'
require 'webmock/minitest'

require 'bintray'

WebMock.allow_net_connect!

def connection_params
  { :endpoint => "https://api.bintray.com",
    :user     => ENV['BINTRAY_TEST_USER'],
    :key      => ENV['BINTRAY_TEST_KEY'] }
end

def auth_for(user, key)
  user && key ? "#{user}:#{key}@" : ''
end

def stub_endpoint(user = nil, key = nil)
  "#{stub_proto}://#{auth_for(user,key)}#{stub_domain}"
end

def stub_safe_endpoint(auth = "(.*:.*@)?")
  stub_request(:any, %r{#{stub_proto}://#{auth}#{stub_domain}})
end

def stub_domain
  "stub-service"
end

def stub_proto
  "http"
end

def force_repository_rollback_of pkg
    require 'httparty'
    HTTParty.delete("https://api.bintray.com/packages/#{connection_params[:user]}/generic/#{pkg}",
                    :basic_auth => { :username => connection_params[:user], :password => connection_params[:key] })
end

module Minitest::Assertions
  def assert_contains_package(pkg, repo)
    assert repo.package?(pkg),
      "expected repo `#{repo.name}` to contain package `#{pkg}`, but it didn't"
  end

  def refute_contains_package(pkg, repo)
    refute repo.package?(pkg),
      "expected repo `#{repo.name}` to not contain package `#{pkg}`, but it did"
  end
end

Bintray::Repository.infect_an_assertion :assert_contains_package, :must_contain_package
Bintray::Repository.infect_an_assertion :refute_contains_package, :wont_contain_package
