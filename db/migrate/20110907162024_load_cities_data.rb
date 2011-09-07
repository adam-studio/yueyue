require 'active_record/fixtures'

class LoadCitiesData < ActiveRecord::Migration
  def self.up
    down
    
    directory = File.join(File.dirname(__FILE__), 'predefined_data')
    Fixtures.create_fixtures(directory, "cities")
  end

  def self.down
    City.delete_all
  end
end
