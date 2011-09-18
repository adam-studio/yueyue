class RemoveTitleFromYueyueTypeActions < ActiveRecord::Migration
  def self.up
    remove_column :yueyue_type_actions, :title
  end

  def self.down
    add_column :yueyue_type_actions, :title, :string
  end
end
