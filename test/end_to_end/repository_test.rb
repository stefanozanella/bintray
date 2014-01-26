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
end
