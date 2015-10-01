# == Schema Information
#
# Table name: events
#
#  email_type_id :integer
#  created_at    :datetime
#  event_type    :integer
#

class Event < ActiveRecord::Base

  TYPE_CLICK = 1
  TYPE_OPEN = 2
  TYPE_SEND = 3

  TYPES_BY_NAME = {
    'click' => TYPE_CLICK,
    'open' => TYPE_OPEN,
    'send' => TYPE_SEND
  }

  belongs_to :email_type
  validates :event_type, presence: true, inclusion: {in: [TYPE_CLICK, TYPE_OPEN, TYPE_SEND]}

  scope :with_event_type, ->(event_type) {
    where(event_type: event_type)
  }

  scope :with_email_type, ->(email_type) {
    where(email_type_id: email_type.id)
  }

  def self.from_json(json)
    begin
      parsed = JSON.parse(json)
      raise "JSON is missing Event or EmailType parameters: #{json}" unless parsed['EmailType'] and parsed['Event']
      event_type = TYPES_BY_NAME[parsed['Event']]
      raise "JSON is contains unsupported Event: #{json}" if event_type.nil?
      email_type = EmailType.find_or_create_by!(name: parsed['EmailType'])
      return Event.new(event_type: event_type, email_type: email_type)
    rescue JSON::ParserError => e
      Rails.logger.error "JSON could not be parsed: #{e.to_s}"
    rescue RuntimeError => e
      Rails.logger.error e.to_s
    end
    nil
  end
end
