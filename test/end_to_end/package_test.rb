require 'test_helper'

describe 'creating a package' do
  let(:client)    { Bintray::Client.new connection_params }
  let(:repo)      { client.repo('generic') }
  let(:pkg_name)  { 'test-package' }
  let(:license)   { 'Apache-2.0' }

  after do
    require 'httparty'
    HTTParty.delete("https://api.bintray.com/packages/#{connection_params[:user]}/generic/#{pkg_name}",
                    :basic_auth => { :username => connection_params[:user], :password => connection_params[:key] })
  end

  it %q{is possible to add a new package into an existing repo, providing only
        the mandatory fields} do
    package = repo.add_package(pkg_name, license)

    assert repo.package?(pkg_name),
      "expected package `#{pkg_name}` to be added to repo `#{repo.name}`, but it was not"

    package.must_be_kind_of Bintray::Package
    package.name.must_equal pkg_name
  end
end
