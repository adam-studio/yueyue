class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.string :account_type
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
