class RemoveEventTypes < ActiveRecord::Migration
  def change
    drop_table :event_types
    remove_column :events, :event_type_id
    add_column :events, :event_type, :integer, length: 2
    add_index :events, [:email_type_id, :event_type]
  end
end
