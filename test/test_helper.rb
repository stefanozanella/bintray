require 'minitest/autorun'
require 'minitest/spec'
require 'mocha/setup'

require 'bintray'

def connection_params
  { :endpoint => "https://api.bintray.com",
    :user     => ENV['BINTRAY_TEST_USER'],
    :key      => ENV['BINTRAY_TEST_KEY'] }
end
