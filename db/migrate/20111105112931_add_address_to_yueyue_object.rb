class AddAddressToYueyueObject < ActiveRecord::Migration
  def self.up
    add_column :yueyue_objects, :address, :string
  end

  def self.down
    remove_column :yueyue_objects, :address
  end
end
