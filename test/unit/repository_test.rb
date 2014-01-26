require 'test_helper'

describe Bintray::Repository do
  describe 'asking for a package' do
    let(:api) { mock }
    let(:repo) { Bintray::Repository.new api, 'name' => 'repo', 'owner' => 'owner' }

    # NOTE: The following two are almost equal, I'm missing something!
    # In particular, if I put the two together, I get a test description with a
    # "and", which smells as too many responsibilities given to Repository
    it 'translates the request into an API call' do
      api.expects(:get).once.with('/packages/owner/repo/test').returns(
        { 'name' => 'test', 'repo' => 'repo', 'owner' => 'owner' })
      repo.package('test')
    end

    it 'translates the JSON response into an object' do
      api.expects(:get).once.with('/packages/owner/repo/test').returns(
        { 'name' => 'test', 'repo' => 'repo', 'owner' => 'owner' })
      reply = repo.package('test')
      reply.must_be_kind_of Bintray::Package
    end
  end
end
