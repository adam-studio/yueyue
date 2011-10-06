class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :nick_name
      t.string :profile_image_url
      t.string :description
      t.string :gender
      t.string :city
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
