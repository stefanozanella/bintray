require 'bintray/base'

module Bintray
  class Package < Base
    attr_reader :name, :repo, :owner, :created
  end
end
