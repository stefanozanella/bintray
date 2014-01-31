require 'test_helper'

describe Bintray::Repository do
  let(:api) { mock }
  let(:repo) { Bintray::Repository.new api, 'name' => 'repo', 'owner' => 'owner' }
  let(:pkg) { 'test' }
  let(:license) { Bintray::License::MIT }
  let(:licenses) { [ Bintray::License::MIT, Bintray::License::BSD ] }

  describe 'asking for a package' do
    it 'translates the request into an API call' do
      api.expects(:get).once.with("/packages/#{repo.owner}/#{repo.name}/#{pkg}").returns(
        { 'name' => pkg, 'repo' => repo.name, 'owner' => repo.owner })
      repo.package(pkg)
    end

    it 'translates the JSON response into an object' do
      api.expects(:get).once.with("/packages/#{repo.owner}/#{repo.name}/#{pkg}").returns(
        { 'name' => pkg, 'repo' => repo.name, 'owner' => repo.owner })
      reply = repo.package(pkg)
      reply.must_be_kind_of Bintray::Package
    end
  end

  describe 'creating a new package' do
    it 'translates the request into a POST API call with the correct body' do
      api.expects(:post).once.with("/packages/#{repo.owner}/#{repo.name}",
                                   { :name => pkg, :licenses => [ license ] })

      repo.add_package(pkg, license)
    end

    it 'allows creating a package with multiple licenses' do
      api.expects(:post).once.with("/packages/#{repo.owner}/#{repo.name}",
                                   { :name => pkg, :licenses => licenses })

      repo.add_package(pkg, licenses)
    end
  end

  describe 'deleting a package' do
    it 'translates the request into a DELETE API call' do
      api.expects(:delete).once.with("/packages/#{repo.owner}/#{repo.name}/#{pkg}")

      repo.del_package(pkg)
    end
  end
end
