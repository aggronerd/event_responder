# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  event_type_id :integer
#  email_type_id :integer
#  created_at    :datetime
#

class Event < ActiveRecord::Base

  belongs_to :event_type
  belongs_to :email_type

  def self.from_json(json)
    begin
      parsed = JSON.parse(json)
    rescue JSON::ParserError => e
      Rails.logger.error "JSON could not be parsed: #{e.to_s}"
      return nil
    end
    unless parsed['EmailType'] and parsed['Event']
      Rails.logger.error "JSON is missing Event or EmailType parameters: #{json}"
      return nil
    end
    email_type = EmailType.find_or_create_by!(name: parsed['EmailType'])
    event_type = EventType.find_or_create_by!(name: parsed['Event'])
    Event.new(event_type: event_type, email_type: email_type)
  end

end
