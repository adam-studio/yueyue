class CreateYueyueObjects < ActiveRecord::Migration
  def self.up
    create_table :yueyue_objects do |t|
      t.integer :yueyue_type_id,  :null => false, :options => "CONSTRAINT fk_yueyue_object_yueyue_types REFERENCES yueyue_types(id)"
      t.string :owner
      t.datetime :create_date
      
      t.timestamps
    end
  end

  def self.down
    drop_table :yueyue_objects
  end
end
