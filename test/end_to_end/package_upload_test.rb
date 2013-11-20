require 'test_helper'

describe 'uploading a package' do
  it %q{is possible to upload a file for an existing package and version
    into an existing repo} do
    skip
    client.upload(package, name, version, repo)
  end
end
