class AddSecurityAccountIdToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :security_account_id, :string
  end

  def self.down
    remove_column :accounts, :security_account_id
  end
end
