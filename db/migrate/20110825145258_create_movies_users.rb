class CreateMoviesUsers < ActiveRecord::Migration
  def self.up
    create_table :movies_users, :id => false do |t|
      t.references :movie
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :movies_users
  end
end
