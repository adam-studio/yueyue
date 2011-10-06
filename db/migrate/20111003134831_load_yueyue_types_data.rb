require 'active_record/fixtures'

class LoadYueyueTypesData < ActiveRecord::Migration
  def self.up
    down
    
    directory = File.join(File.dirname(__FILE__), 'predefined_data')
    Fixtures.create_fixtures(directory, "yueyue_types")
    Fixtures.create_fixtures(directory, "yueyue_type_properties")
    Fixtures.create_fixtures(directory, "yueyue_type_actions")
  end

  def self.down
    YueyueType.delete_all
    YueyueTypeAction.delete_all
    YueyueTypeProperty.delete_all
  end
end
