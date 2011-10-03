class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.string :account_type
      t.integer :user_id
      t.string :request_token
      t.string :request_token_secret
      t.string :access_token
      t.string :access_token_secret

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
