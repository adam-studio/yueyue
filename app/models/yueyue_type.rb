class YueyueType < ActiveRecord::Base
  has_many :yueyue_type_properties
  has_many :yueyue_type_actions
  has_many :yueyue_type_objects
end
