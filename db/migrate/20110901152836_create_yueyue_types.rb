class CreateYueyueTypes < ActiveRecord::Migration
  def self.up
    create_table :yueyue_types do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :yueyue_types
  end
end
