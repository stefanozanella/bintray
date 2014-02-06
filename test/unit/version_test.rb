require 'test_helper'

describe Bintray::Version do
  let(:api) { mock }
  let(:fs) { mock }
  let(:package_path) { "path/to/package.bin" }
  let(:package_content) { "some.binary.content" }

  let(:version) { Bintray::Version.new api, fs,
                  'name' => 'version', 'owner' => 'owner', 'repo' => 'repo',
                  'package' => 'package' }

  it 'fetches the package content and PUTs it to the API endpoint' do
    fs.expects(:fetch).once.with(package_path).returns(package_content)
    api.expects(:put).once.with("/content/owner/repo/package/version/#{package_path};publish=0",
                                 package_content)

    version.upload(package_path)
  end

  it 'fetches the package content and PUTs it to the API endpoint, publishing it' do
    fs.expects(:fetch).once.with(package_path).returns(package_content)
    api.expects(:put).once.with("/content/owner/repo/package/version/#{package_path};publish=1",
                                 package_content)

    version.publish(package_path)
  end
end
