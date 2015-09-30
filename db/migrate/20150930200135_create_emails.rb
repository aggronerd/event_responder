class CreateEmails < ActiveRecord::Migration
  def change
    create_table :email_types do |t|
      t.string :name, null: false, unique: true, index: true, limit: 128
    end
  end
end
