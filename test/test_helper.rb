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

def stub_endpoint
  "http://stub-service"
end
