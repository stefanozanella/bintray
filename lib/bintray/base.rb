module Bintray
  class Base
    class << self
      # Construct an object from an hash of attributes
      #
      # @param attrs [Hash]
      def from_hash attrs
        new attrs
      end

      def attr_reader(*attrs)
        attrs.each do |attr|
          define_attribute_reader(attr)
        end
      end

      def define_attribute_reader(attr)
        define_method(attr) do ||
          @attrs[attr.to_s]
        end
      end
    end

    private

    def initialize(attrs)
      @attrs = attrs
    end
  end
end
