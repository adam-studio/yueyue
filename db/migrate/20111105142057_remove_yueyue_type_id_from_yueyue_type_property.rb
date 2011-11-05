class RemoveYueyueTypeIdFromYueyueTypeProperty < ActiveRecord::Migration
  def self.up
    remove_column :yueyue_type_properties, :yueyue_type_id
  end

  def self.down
    add_column :yueyue_type_properties, :yueyue_type_id, :integer
  end
end
