require 'time'
require 'bintray/package'

module Bintray
  class Repository < Entity
    attr :name, :owner, :desc, :labels, :package_count

    def package(pkg)
      Package.new @api, @api.get("/packages/#{owner}/#{name}/#{pkg}")
    end
  end
end
