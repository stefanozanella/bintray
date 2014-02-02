require 'test_helper'

describe 'managing versions' do
  let(:client)  { Bintray::Client.new connection_params }
  let(:package) { client.repo('generic').package('stub') }

  it 'is possible to retrieve a specific version for a package' do
    version = package.version('0.0.1')
    version.must_be_kind_of Bintray::Version
    version.name.must_equal '0.0.1'
    version.package.must_equal 'stub'
    version.repo.must_equal 'generic'
    version.owner.must_equal 'bintray-test-user'
    version.desc.must_equal 'The first version'
    version.created.must_equal Time.parse("2014-02-01T20:25:30.775Z")
    version.updated.must_equal Time.parse("2014-02-01T20:33:27.742Z")
    version.released.must_equal Time.parse("2014-02-01T00:00:00.000Z")
    version.labels.must_include 'stub'
    version.labels.must_include 'test'
    version.ordinal.must_equal 0
  end

  it 'is possible to know if a version exists for a specific package' do
    package.must_contain_version '0.0.2'
    package.wont_contain_version 'not.a.real.version.number'
  end
end
