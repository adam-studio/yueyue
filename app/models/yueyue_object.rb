#encoding: UTF-8
class YueyueObject < ActiveRecord::Base
  validates_presence_of :title, :message=>'约约内容不能为空'
  validates_presence_of :yueyue_date, :message=>'约约时间不能为空'
  
  belongs_to :yueyue_type
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :yueyue_object_properties
  has_many :messages
  has_and_belongs_to_many :users, :uniq => true

  # vitrual params
  attr_accessor :weibo_types
end
