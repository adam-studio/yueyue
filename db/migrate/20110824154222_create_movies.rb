class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :description
      t.datetime :yueyue_date
      t.string :movie_name
      t.string :place
      t.integer :ticket_fee
      t.string :yueyue_owner

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
