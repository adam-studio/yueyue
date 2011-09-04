class CreateYueyueObjectProperties < ActiveRecord::Migration
  def self.up
    create_table :yueyue_object_properties do |t|
      t.integer :yueyue_object_id,  :null => false, :options => "CONSTRAINT fk_yueyue_object_peroperty_yueyue_objects REFERENCES yueyue_objects(id)"
      t.integer :yueyue_type_property_id,  :null => false, :options => "CONSTRAINT fk_yueyue_object_peroperty_yueyue_type_properties REFERENCES yueyue_type_properties(id)"
      t.string :property_value
      t.timestamps
    end
  end

  def self.down
    drop_table :yueyue_object_properties
  end
end
