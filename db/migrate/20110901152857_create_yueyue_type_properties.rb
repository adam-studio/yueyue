class CreateYueyueTypeProperties < ActiveRecord::Migration
  def self.up
    create_table :yueyue_type_properties do |t|
      t.integer :yueyue_type_id,  :null => false, :options => "CONSTRAINT fk_yueyue_type_peroperty_yueyue_types REFERENCES yueyue_types(id)"
      t.string :name
      t.string :data_type
      t.integer :max_size
      t.integer :min_size
      t.boolean :null_able
      t.string :default_value
      t.timestamps
    end
  end

  def self.down
    drop_table :yueyue_type_properties
  end
end
