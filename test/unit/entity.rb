require 'test_helper'

describe Bintray::Entity do
  it 'is a base for creating entities with custom fields' do
    entity_class = Class.new(Bintray::Entity) do
      attr :field
    end

    entity = entity_class.new nil, 'field' => 'value'

    entity.field.must_equal 'value'
  end
end
