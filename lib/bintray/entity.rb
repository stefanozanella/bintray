module Bintray
  class Entity
    class << self
      def attr(*attrs)
        attrs.each do |attr|
          define_accessors_for(attr)
        end
      end

      private

      def define_accessors_for(attr)
        define_method(attr) do
          raw_attrs[attr.to_s]
        end

        define_method("#{attr}=") do |value|
          raw_attrs[attr.to_s] = value
        end
      end
    end

    def initialize(api, attrs = {})
      @api = api
      @raw_attrs = attrs
    end

    def created
      Time.parse raw_attrs['created']
    end

    def updated
      Time.parse raw_attrs['updated']
    end

    private

    def raw_attrs
      @raw_attrs
    end
  end
end
