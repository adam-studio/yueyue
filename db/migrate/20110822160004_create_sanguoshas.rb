class CreateSanguoshas < ActiveRecord::Migration
  def self.up
    create_table :sanguoshas do |t|
      t.string :description
      t.datetime :yueyue_date
      t.string :place

      t.timestamps
    end
  end

  def self.down
    drop_table :sanguoshas
  end
end
