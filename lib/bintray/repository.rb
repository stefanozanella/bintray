require 'bintray/package'

module Bintray
  class Repository < Entity
    attr :name, :owner, :desc, :labels, :package_count

    def package?(pkg)
      package(pkg)
      true
    rescue Error::NotFound
      false
    end

    def package(pkg)
      Package.new @api, @api.get("/packages/#{owner}/#{name}/#{pkg}")
    end

    def add_package(pkg, licenses)
      Package.new @api, @api.post("/packages/#{owner}/#{name}", {:name => pkg, :licenses => [ licenses ].flatten })
    end
  end
end
