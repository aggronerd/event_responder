# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  name :string(128)      not null
#

require 'test_helper'

class EventTypeTest < ActiveSupport::TestCase

  setup do
    @event_type = event_types(:click)
  end

  test 'validation: name required' do
    assert_not @event_type.update(name: nil)
    assert_not @event_type.update(name: '')
  end

  test 'validation: name length' do
    assert @event_type.update(name: 'a'*128)
    assert_not @event_type.update(name: 'a'*129)
  end

  test 'association: events' do
    assert_not_empty @event_type.events
  end

end
