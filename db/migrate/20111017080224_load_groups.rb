class LoadGroups < ActiveRecord::Migration
  def self.up
    down

    directory = File.join(File.dirname(__FILE__), 'predefined_data')
    Fixtures.create_fixtures(directory, "groups")
  end

  def self.down
    Group.delete_all()
  end
end
