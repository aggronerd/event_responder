class EventsController < ApplicationController

  skip_before_action :verify_authenticity_token, if: :json_request?, only: [ :record ]

  def record
    event = Event.from_json(request.body.read)
    if event
      event.save!
      render nothing: true, status: 200
    else
      render nothing: true, status: 400
    end

  end

  def summary
    @sent_count = Event.with_event_type(Event::TYPE_SEND).count
    @open_count = Event.with_event_type(Event::TYPE_OPEN).count
    @click_count = Event.with_event_type(Event::TYPE_CLICK).count
    @email_type_open_rates, @email_type_click_rates= {}, {}
    EmailType.find_each do |email_type|
      name = email_type.name
      total_sent = Event.with_event_type(Event::TYPE_SEND).with_email_type(email_type).count
      if total_sent > 0
        @email_type_open_rates[name] = rates_for(email_type, Event::TYPE_OPEN, total_sent)
        @email_type_click_rates[name] = rates_for(email_type, Event::TYPE_CLICK, total_sent)
      else
        @email_type_open_rates[name], @email_type_click_rates[name] = nil, nil
      end
    end
  end

private

  def rates_for(email_type, event_type, total_sent)
    (Event.with_event_type(event_type).with_email_type(email_type).count.to_f / total_sent.to_f).round(2)
  end

  def json_request?
    request.format.json?
  end

end
