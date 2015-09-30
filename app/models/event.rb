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

end
