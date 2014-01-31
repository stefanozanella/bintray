require 'test_helper'

describe Bintray::Repository do
  let(:client) { Bintray::Client.new connection_params }
  let(:repo) { client.repo('generic') }

  describe 'looking for a repository' do
    it 'is possible to retrieve info about a repo given its name' do

      repo.must_be_kind_of Bintray::Repository
      repo.name.must_equal 'generic'
      repo.owner.must_equal 'bintray-test-user'
      repo.desc.must_equal 'Set of generic binaries.'
      repo.created.must_equal Time.parse("2013-11-20T12:50:42.405Z")
      repo.labels.must_include 'generic'
      repo.labels.must_include 'test'
      repo.package_count.must_be :>, 0
    end

    it 'throws an error if the specified repository doesn`t exist' do
      error = proc { client.repo('non_existent') }.must_raise Bintray::Error::NotFound
      error.message.must_match(/repo 'non_existent' was not found/i)
    end

    it 'tells whether a repo exists or not' do
      assert client.repo?('generic'), 'expected repo `generic` to exist'
      refute client.repo?('non_existent'), 'expected repo `non_existent` to NOT exist'
    end
  end

  describe 'using a repository' do
    it 'tells whether a specific package exists in the repo or not' do
      assert repo.package?('stub'), 'expected package `stub` to exist within repo `generic`'
      refute repo.package?('non_existent'), 'expected package `non_existent` to NOT exist within repo `generic`'
    end

    it 'is possible to retrieve info about a package belonging to the repo' do
      repo = client.repo('generic')
      package = repo.package('stub')

      package.must_be_kind_of Bintray::Package
      package.name.must_equal 'stub'
      package.repo.must_equal 'generic'
      package.owner.must_equal 'bintray-test-user'
      package.desc.must_equal 'A stub package without actual content.'
      package.created.must_equal Time.parse("2014-01-25T19:38:09.601Z")
      package.updated.must_equal Time.parse("2014-01-25T19:38:09.601Z")
      package.labels.must_include 'stub'
      package.labels.must_include 'test'
    end

    it 'throws an error if the specified package doesn`t exist' do
      error = proc { repo.package('non_existent') }.must_raise Bintray::Error::NotFound
      error.message.must_match(/package 'non_existent' was not found/i)
    end
  end
end
