require 'test_helper'

describe 'looking for a repository' do
  let(:client) { Bintray::Client.new connection_params }

  it 'is possible to retrieve info about a repo given its name' do
    repo = client.repo('generic')

    repo.must_be_kind_of Bintray::Repository
    repo.name.must_equal 'generic'
    repo.owner.must_equal 'bintray-test-user'
    repo.desc.must_equal 'Set of generic binaries.'
    repo.created.must_equal Time.parse("2013-11-20T12:50:42.405Z")
    repo.labels.must_include 'generic'
    repo.labels.must_include 'test'
    repo.package_count.must_equal 1
  end

  it 'throws an error if the specified repository doesn`t exist' do
    error = proc { client.repo('non_existent') }.must_raise Bintray::Error::NotFound
    error.message.must_match(/repo 'non_existent' was not found/i)
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
end
