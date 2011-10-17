class Group < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :groups_users, :class_name => "GroupsUsers"
  has_many :users, :class_name => "User", :through => :groups_users, :source => :user
end
