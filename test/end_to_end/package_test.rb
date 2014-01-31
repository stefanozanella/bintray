require 'test_helper'

describe 'managing packages' do
  let(:client)    { Bintray::Client.new connection_params }
  let(:repo)      { client.repo('generic') }
  let(:license)   { Bintray::License::MIT }

  after do
    require 'httparty'
    HTTParty.delete("https://api.bintray.com/packages/#{connection_params[:user]}/generic/#{pkg_name}",
                    :basic_auth => { :username => connection_params[:user], :password => connection_params[:key] })
  end

  describe 'creating a package' do
    let(:pkg_name)  { 'test-package' }

    it %q{is possible to add a new package into an existing repo, providing only
          the mandatory fields} do
      package = repo.add_package(pkg_name, license)

      assert repo.package?(pkg_name),
        "expected package `#{pkg_name}` to be added to repo `#{repo.name}`, but it was not"

      package.must_be_kind_of Bintray::Package
      package.name.must_equal pkg_name
    end
  end

  describe 'deleting a package' do
    let(:pkg_name)  { 'scrap' }

    before do
      repo.add_package(pkg_name, license)
    end

    it 'is possible to delete a package belonging to a repo' do
      repo.del_package(pkg_name)

      refute repo.package?(pkg_name),
        "expected `#{pkg_name}` to have been deleted from repo `#{repo.name}`, but it was still there"
    end
  end
end
