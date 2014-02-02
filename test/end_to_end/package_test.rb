require 'test_helper'

describe 'managing packages' do
  let(:client)    { Bintray::Client.new connection_params }
  let(:repo)      { client.repo('generic') }
  let(:license)   { Bintray::License::MIT }

  after do
    force_package_rollback pkg_name
  end

  describe 'creating a package' do
    let(:pkg_name)  { 'test-package' }

    it %q{is possible to add a new package into an existing repo, providing only
          the mandatory fields} do
      package = repo.add_package(pkg_name, license)

      repo.must_contain_package pkg_name
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
      repo.wont_contain_package pkg_name
    end
  end
end
