module Bintray
  class Version < Entity
    attr :name, :package, :repo, :desc, :owner, :labels, :ordinal
  end
end
