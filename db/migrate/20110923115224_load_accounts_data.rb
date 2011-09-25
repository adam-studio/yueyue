class LoadAccountsData < ActiveRecord::Migration
  def self.up
    down
    
    directory = File.join(File.dirname(__FILE__), 'predefined_data')
    Fixtures.create_fixtures(directory, "accounts")

  end

  def self.down
    Account.delete_all
  end
end
