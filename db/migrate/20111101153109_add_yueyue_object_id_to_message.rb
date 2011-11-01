class AddYueyueObjectIdToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :yueyue_object_id, :integer
  end

  def self.down
    remove_column :messages, :yueyue_object_id
  end
end
