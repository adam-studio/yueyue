class AddOwnerToSanguosha < ActiveRecord::Migration
  def self.up
    add_column :sanguoshas, :yueyue_owner, :string
  end

  def self.down
    remove_column :sanguoshas, :yueyue_owner
  end
end
