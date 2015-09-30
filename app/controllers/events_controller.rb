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

private

  def json_request?
    request.format.json?
  end

end
