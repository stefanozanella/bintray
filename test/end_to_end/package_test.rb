require 'test_helper'

describe 'package creation' do
  let(:client)  { Bintray::Client.new connection_params }
  let(:package) { 'sample_app' }
  let(:license) { 'Apache-2.0' }
  let(:repo)    { test_repo }

  after do
    delete_bintray_package(repo, package)
  end

  it 'is possible to create a new package into an existing repo' do
    client.create_package(package, license, repo)

    bintray_packages_in(repo).must_include(package)
  end
end
