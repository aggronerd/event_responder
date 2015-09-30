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

  test 'from_json: with existing both' do
    event = Event.from_json('{"Address":"vitor@lostmy.name","EmailType":"Shipment","Event":"open","Timestamp":1443645841}')
    assert_difference 'Event.count', 1 do
      assert event.save
    end
    assert_equal email_types(:shipment), event.email_type
    assert_equal event_types(:open), event.event_type
  end

  test 'from_json: with new event type' do
    assert_difference 'EventType.count', 1 do
      assert_difference 'Event.count', 1 do
        event = Event.from_json('{"Address":"vitor@lostmy.name","EmailType":"Shipment","Event":"view","Timestamp":1443645841}')
        assert event.save
        assert_equal email_types(:shipment), event.email_type
        assert_equal 'view', event.event_type.name
      end
    end
  end

  test 'from_json: with new email type' do
    assert_difference 'EmailType.count', 1 do
      assert_difference 'Event.count', 1 do
        event = Event.from_json('{"Address":"vitor@lostmy.name","EmailType":"Bulletin","Event":"open","Timestamp":1443645841}')
        assert event.save
        assert_equal 'Bulletin', event.email_type.name
        assert_equal event_types(:open), event.event_type
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

end
