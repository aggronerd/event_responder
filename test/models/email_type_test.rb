# == Schema Information
#
# Table name: email_types
#
#  id   :integer          not null, primary key
#  name :string(128)      not null
#

require 'test_helper'

class EmailTypeTest < ActiveSupport::TestCase

  setup do
    @email_type = email_types(:shipment)
  end

  test 'validation: name required' do
    assert_not @email_type.update(name: nil)
    assert_not @email_type.update(name: '')
  end

  test 'validation: name length' do
    assert @email_type.update(name: 'a'*128)
    assert_not @email_type.update(name: 'a'*129)
  end

  test 'association: events' do
    assert_not_empty @email_type.events
  end

end
