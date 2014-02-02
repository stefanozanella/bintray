require 'test_helper'

describe Bintray::API do
  let(:resource_path) { "/path/to/resource" }
  let(:resource_url) { "#{stub_endpoint}#{resource_path}" }
  let(:request_body) { { :attribute1 => :value1, :attribute2 => [ :value2, :value3 ] } }
  let(:api) { Bintray::API.new stub_endpoint }

  before do
    stub_safe_endpoint
  end

  it 'makes a GET HTTP request against the configured endpoint' do
    request = stub_request(:get, resource_url)
    api.get(resource_path)

    assert_requested request
  end

  it 'makes a POST HTTP request against the configured endpoint, passing data as JSON' do
    request = stub_request(:post, resource_url)
    api.post(resource_path, request_body)

    assert_requested request, :body => request_body.to_json,
      :headers => { 'Content-Type' => 'application/json' }
  end

  it 'makes a DELETE HTTP request against the configured endpoint' do
    request = stub_request(:delete, resource_url)
    api.delete(resource_path)

    assert_requested request
  end

  it 'throws an error when the resource is not found' do
    stub_request(:get, resource_url).to_return(
      :body => "not found", :status => 404)

    proc { api.get(resource_path) }.must_raise Bintray::Error::NotFound
  end

  describe 'making authenticated requests' do
    let(:user) { "test_user" }
    let(:key)  { "test_key" }
    let(:authenticated_resource_url) { "#{stub_endpoint user, key}#{resource_path}" }
    let(:api) { Bintray::API.new stub_endpoint, user, key }

    it 'performs an authenticated request when a user/key pair is defined' do
      request = stub_request(:post, authenticated_resource_url)
      api.post(resource_path, request_body)
      assert_requested request

      request = stub_request(:delete, authenticated_resource_url)
      api.delete(resource_path)
      assert_requested request

      request = stub_request(:get, authenticated_resource_url)
      api.get(resource_path)
      assert_requested request
    end
  end
end
