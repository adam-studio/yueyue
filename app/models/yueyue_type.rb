class YueyueType < ActiveRecord::Base
  belongs_to :parent_type, :class_name => "yueyueType"
  has_many :yueyue_type_properties
  has_many :yueyue_type_actions
end
