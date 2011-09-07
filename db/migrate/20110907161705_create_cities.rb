class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :name
      t.string :area_code
      t.string :pinyin
      t.integer :rate

      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
