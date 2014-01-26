#require 'test_helper'
#
#describe 'package creation' do
#  let(:client)    { Bintray::Client.new connection_params }
#  let(:pkg_name)  { 'sample_app' }
#  let(:license)   { 'Apache-2.0' }
#  let(:repo)      { test_repo }
#
#  after do
#    delete_bintray_package(repo, pkg_name)
#  end
#
#  it 'is possible to create a new package into an existing repo' do
#    package = client.create_package(pkg_name, license, repo)
#
#    bintray_packages_in(repo).must_include(pkg_name)
#
#    package.must_be_kind_of Bintray::Package
#    package.name.must_equal pkg_name
#  end
#end
