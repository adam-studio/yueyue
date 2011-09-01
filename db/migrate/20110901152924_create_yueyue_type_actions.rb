class CreateYueyueTypeActions < ActiveRecord::Migration
  def self.up
    create_table :yueyue_type_actions do |t|
      t.integer :yueyue_type_id,  :null => false, :options => "CONSTRAINT fk_yueyue_type_action_yueyue_types REFERENCES yueyue_types(id)"
      t.string :name
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :yueyue_type_actions
  end
end
