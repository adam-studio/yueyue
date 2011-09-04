class CreateUsersYueyueObjects < ActiveRecord::Migration
  def self.up
      create_table :users_yueyue_objects, :id => false do |t|
        t.references :yueyue_object
        t.references :user

        t.timestamps
      end
    end

    def self.down
      drop_table :users_yueyue_objects
    end
end
