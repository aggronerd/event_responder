require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  test 'Routing: record an event' do
    assert_routing({path: '/events', method: :post}, {controller: 'events', action: 'record'})
  end

  test 'record: valid JSON' do
    assert_difference 'Event.count', 1 do
      post :record, '{"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696}', format: :json
    end
    assert_response :success
  end

  test 'record: invalid JSON' do
    assert_no_difference 'Event.count' do
      post :record, '{"Address":"barney@lostmy.name","EmailType":"Shipment","Event":"send","Timestamp":1432820696', format: :json
    end
    assert_response :bad_request
  end

  test 'record: missing property' do
    assert_no_difference 'Event.count' do
      post :record, '{"Address":"barney@lostmy.name","Timestamp":1432820696}', format: :json
    end
    assert_response :bad_request
  end

end
