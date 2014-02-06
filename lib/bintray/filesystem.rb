module Bintray
  class Filesystem
    def fetch(filename)
      File.read(filename)
    end
  end
end
