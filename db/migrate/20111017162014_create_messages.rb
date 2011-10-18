class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.integer :other_user_id
      t.integer :message_type
      t.text :content
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
