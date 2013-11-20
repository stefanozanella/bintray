require 'minitest/autorun'
require 'minitest/spec'
require 'mocha/setup'

require 'bintray'

require 'json'
require 'httparty'

def connection_params
  { :endpoint => "https://api.bintray.com",
    :user     => ENV['BINTRAY_TEST_USER'],
    :key      => ENV['BINTRAY_TEST_KEY'] }
end

def test_repo
  "generic"
end

def bintray_packages_in(repo)
  get(packages_url(repo)).map { |p| p['name'] }
end

def delete_bintray_package(repo, package)
  delete(delete_package_url(repo, package))
end

def delete_package_url(repo, package)
  "#{connection_params[:endpoint]}/packages/#{connection_params[:user]}/#{repo}/#{package}"
end

def packages_url(repo)
  "#{connection_params[:endpoint]}/repos/#{connection_params[:user]}/#{repo}/packages"
end

def delete(url)
  HTTParty.delete(url,:basic_auth => auth_hash).body
end

def get(url)
  JSON.parse(HTTParty.get(url).body)
end

def auth_hash
  { :username => connection_params[:user], :password => connection_params[:key] }
end
