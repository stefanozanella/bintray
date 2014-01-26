require 'time'

module Bintray
  class Repository
    attr_reader :name, :owner, :desc, :labels, :package_count, :created

    def initialize(attrs = {})
      attrs.each do |attr, value|
        self.send("#{attr}=", value)
      end
    end

    private

    attr_writer :name, :owner, :desc, :labels, :package_count

    def created=(value)
      @created = Time.parse(value)
    end
  end
end
