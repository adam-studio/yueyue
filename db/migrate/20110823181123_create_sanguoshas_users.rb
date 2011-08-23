class CreateSanguoshasUsers < ActiveRecord::Migration
  def self.up
    create_table :sanguoshas_users, :id => false do |t|
      t.references :sanguosha
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :sanguoshas_users
  end
end
