require 'test_helper'

describe Bintray::Filesystem do
  let(:fs) { Bintray::Filesystem.new }

  it 'fetches file content and returns it as a string' do
    content = fs.fetch(fixture_binary)
    content.must_be_kind_of String
    content.wont_be_empty
  end
end
