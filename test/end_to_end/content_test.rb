require 'test_helper'

describe 'managing version content' do
  let(:client)  { Bintray::Client.new connection_params }
  let(:version) { client.repo('generic').package('stub').version(version_no) }

  describe 'uploading content' do
    let(:version_no) { '0.0.4.upload' }

    it 'is possible to upload a binary package relative to a specific version' do
      assert version.upload(fixture_binary),
        'expected content upload to be successful, but it failed'
    end
  end

  describe 'publishing content' do
    let(:version_no) { '0.0.4.publish' }

    it 'is possible to publish a binary package relative to a specific version' do
      assert version.publish(fixture_binary),
        'expected content to be published, but it was not'
    end
  end
end
