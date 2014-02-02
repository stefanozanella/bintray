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
  def assert_contains_repo(repo, client)
    assert client.repo?(repo),
      "expected repo `#{repo}` to exist, but it didn't"
  end

  def refute_contains_repo(repo, client)
    refute client.repo?(repo),
      "expected repo `#{repo}` to not exist, but it did"
  end

  def assert_contains_package(pkg, repo)
    assert repo.package?(pkg),
      "expected repo `#{repo.name}` to contain package `#{pkg}`, but it didn't"
  end

  def refute_contains_package(pkg, repo)
    refute repo.package?(pkg),
      "expected repo `#{repo.name}` to not contain package `#{pkg}`, but it did"
  end

  def assert_contains_version(version, package)
    assert package.version?(version),
      "expected version `#{version}` to exist for package `#{package}`, but it didn't"
  end

  def refute_contains_version(version, package)
    refute package.version?(version),
      "expected version `#{version}` to not exist for package `#{package}`, but it did"
  end
end

Bintray::Client.infect_an_assertion :assert_contains_repo, :must_contain_repo
Bintray::Client.infect_an_assertion :refute_contains_repo, :wont_contain_repo

Bintray::Repository.infect_an_assertion :assert_contains_package, :must_contain_package
Bintray::Repository.infect_an_assertion :refute_contains_package, :wont_contain_package

Bintray::Package.infect_an_assertion :assert_contains_version, :must_contain_version
Bintray::Package.infect_an_assertion :refute_contains_version, :wont_contain_version
