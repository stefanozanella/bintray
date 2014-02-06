module Bintray
  class Version < Entity
    attr :name, :package, :repo, :desc, :owner, :labels, :ordinal

    def initialize(api, fs, attrs = {})
      super(api, attrs)
      @fs = fs
    end

    def upload(filename, publish = false)
      resp = @api.put("/content/#{owner}/#{repo}/#{package}/#{name}/#{filename}#{publish_param(publish)}",
                      @fs.fetch(filename))
      begin
        resp["message"] == "success"
      rescue NoMethodError
        false
      end
    end

    def publish(filename)
      upload(filename, true)
    end

    private

    def publish_param(flag)
      ";publish=#{flag ? "1" : "0" }"
    end
  end
end
