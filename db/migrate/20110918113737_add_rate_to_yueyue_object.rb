class AddRateToYueyueObject < ActiveRecord::Migration
  def self.up
    add_column :yueyue_objects, :rate, :integer
  end

  def self.down
    remove_column :yueyue_objects, :rate
  end
end
