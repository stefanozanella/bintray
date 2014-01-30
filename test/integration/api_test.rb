require 'test_helper'

describe Bintray::API do
  let(:resource_path) { "/path/to/resource" }
  let(:resource_url) { "#{stub_endpoint}#{resource_path}" }
  let(:api) { Bintray::API.new stub_endpoint }

  it 'makes a GET HTTP request against the configured endpoint' do
    request = stub_request(:get, resource_url)
    api.get(resource_path)

    assert_requested request
  end

  it 'throws an error when the resource is not found' do
    stub_request(:get, resource_url).to_return(
      :body => "not found", :status => 404)

    proc { api.get(resource_path) }.must_raise Bintray::Error::NotFound
  end
end
