# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  event_type_id :integer
#  email_type_id :integer
#  created_at    :datetime
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase

  setup do
    @event = Event.new(event_type: event_types(:send), email_type: email_types(:shipment))
    @event.save!
  end

  test 'created_at: set on creation' do
    assert_operator @event.created_at, :>, 5.seconds.ago
  end

  test 'association: event_type' do
    assert_equal EventType, @event.event_type.class
  end

  test 'association: email_type' do
    assert_equal EmailType, @event.email_type.class
  end

end
