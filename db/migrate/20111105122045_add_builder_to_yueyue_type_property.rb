class AddBuilderToYueyueTypeProperty < ActiveRecord::Migration
  def self.up
    add_column :yueyue_type_properties, :builder, :integer
  end

  def self.down
    remove_column :yueyue_type_properties, :builder
  end
end
