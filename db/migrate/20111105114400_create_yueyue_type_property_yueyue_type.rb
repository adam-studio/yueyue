class CreateYueyueTypePropertyYueyueType < ActiveRecord::Migration
  def self.up
      create_table :yueyue_type_properties_yueyue_types, :id => false do |t|
        t.references :yueyue_type
        t.references :yueyue_type_property

        t.timestamps
      end
    end

    def self.down
      drop_table :yueyue_type_properties_yueyue_types
    end
end
