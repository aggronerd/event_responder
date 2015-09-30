# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  name :string(128)      not null
#

class EventType < ActiveRecord::Base

  has_many :events, dependent: :destroy

  validates :name, presence: true, length: {maximum: 128}

end
