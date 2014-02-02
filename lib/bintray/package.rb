module Bintray
  class Package < Entity
    attr :name, :repo, :owner, :desc, :labels, :attribute_names,
      :followers_count, :versions, :latest_version, :rating_count,
      :system_ids, :vcs_url

    def version(ver)
      Version.new @api, @api.get("/packages/#{owner}/#{repo}/#{name}/versions/#{ver}")
    end
  end
end
