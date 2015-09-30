class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, id: false do |t|
      t.references :event_type, nil: false, index: true
      t.references :email_type, nil: false, index: true
      t.timestamp :created_at, nil: false
    end
  end
end
