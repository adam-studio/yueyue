class YueyueObject < ActiveRecord::Base
  belongs_to :yueyue_type
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :yueyue_object_properties
  has_and_belongs_to_many :users, :uniq => true

  # vitrual params
  attr_accessor :weibo_types
end
