# == Schema Information
#
# Table name: events
#
#  email_type_id :integer
#  created_at    :datetime
#  event_type    :integer
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase

  setup do
    @event = Event.new(event_type: Event::TYPE_CLICK, email_type: email_types(:shipment))
    @event.save!
  end

  test 'created_at: set on creation' do
    assert_operator @event.created_at, :>, 5.seconds.ago
  end

  test 'validation: event_type required' do
    assert_not @event.update(event_type: nil)
  end

  test 'validation: event_type inclusion' do
    assert_not @event.update(event_type: 8)
    assert_not @event.update(event_type: 4)
    assert @event.update(event_type: Event::TYPE_CLICK)
  end

  test 'association: email_type' do
    assert_equal EmailType, @event.email_type.class
  end

  test 'from_json: with existing both' do
    event = Event.from_json('{"Address":"vitor@lostmy.name","EmailType":"Shipment","Event":"open","Timestamp":1443645841}')
    assert_difference 'Event.count', 1 do
      assert event.save
    end
    assert_equal email_types(:shipment), event.email_type
    assert_equal Event::TYPE_OPEN, event.event_type
  end

  test 'from_json: with unknown event type' do
    assert_no_difference 'Event.count' do
      assert_nil Event.from_json('{"Address":"vitor@lostmy.name","EmailType":"Shipment","Event":"view","Timestamp":1443645841}')
    end
  end

  test 'from_json: with new email type' do
    assert_difference 'EmailType.count', 1 do
      assert_difference 'Event.count', 1 do
        event = Event.from_json('{"Address":"vitor@lostmy.name","EmailType":"Bulletin","Event":"open","Timestamp":1443645841}')
        assert event.save
        assert_equal 'Bulletin', event.email_type.name
        assert_equal Event::TYPE_OPEN, event.event_type
      end
    end
  end

  test 'from_json: missing email type' do
    assert_nil Event.from_json('{"Address":"vitor@lostmy.name","Event":"open","Timestamp":1443645841}')
  end

  test 'from_json: missing event type' do
    assert_nil Event.from_json('{"Address":"vitor@lostmy.name","EmailType":"Bulletin","Timestamp":1443645841}')
  end

  test 'from_json: invalid json' do
    assert_nil Event.from_json('{"Address":')
  end

  test 'with_event_type scope' do
    assert 1, Event.with_event_type(Event::TYPE_OPEN).count
  end

  test 'with_email_type scope' do
    assert 1, Event.with_email_type(email_types(:shipment)).count
  end

  test 'scope combination' do
    assert 1, Event.with_email_type(email_types(:shipment)).with_event_type(Event::TYPE_CLICK).count
    assert 1, Event.with_email_type(email_types(:shipment)).with_event_type(Event::TYPE_OPEN).count
  end

end
