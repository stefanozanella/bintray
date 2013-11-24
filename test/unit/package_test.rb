require 'test_helper'

describe Bintray::Package do
  let(:hash) {{
    'name'    => 'pkg_name',
    'repo'    => 'pkg_repo',
    'owner'   => 'repo_owner',
    'created' => '2013-11-24T16:49:36.737Z'
  }}

  it 'can be created from a Hash of attributes' do
    obj = Bintray::Package.from_hash hash
    hash.keys.each do |key|
      obj.send(key.to_sym).must_equal hash[key]
    end
  end
end
