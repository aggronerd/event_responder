class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :name, null: false, unique: true, index: true, limit: 128
    end
  end
end
