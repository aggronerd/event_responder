# == Schema Information
#
# Table name: email_types
#
#  id   :integer          not null, primary key
#  name :string(128)      not null
#

class EmailType < ActiveRecord::Base

  has_many :events, dependent: :destroy

  validates :name, presence: true, length: {maximum: 128}

  def get_rate(event_type)
    Event.where(event_type: event_type, email_type: self).count
    Event.where(event_type: sent, email_type: self).count
  end

end
