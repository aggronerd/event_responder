require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  test 'Routing: record an event' do
    assert_routing({path: '/events', method: :post}, {controller: 'events', action: 'record'})
  end

  test 'Routing: summary' do
    assert_routing '/events', controller: 'events', action: 'summary'
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

  test 'summary: displays and is correct' do
    get :summary
    assert_response :success
    assert_select 'h1', 'Summary'
    assert_select 'ul.count li:nth-child(1)', /\AEmails sent:\s+4\Z/
    assert_select 'ul.count li:nth-child(2)', /\AEmails opened:\s+2\Z/
    assert_select 'ul.count li:nth-child(3)', /\AEmails clicked:\s+3\Z/
    assert_select 'ul.open-rates li:nth-child(1)', /\AShipment:\s+33.33%\Z/
    assert_select 'ul.open-rates li:nth-child(2)', /\AUserConfirmation:\s+100.0%\Z/
    assert_select 'ul.open-rates li:nth-child(3)', /\AUserActivation:\s+N\/A\Z/
    assert_select 'ul.click-rates li:nth-child(1)', /\AShipment:\s+66.67%\Z/
    assert_select 'ul.click-rates li:nth-child(2)', /\AUserConfirmation:\s+100.0%\Z/
  end

end
