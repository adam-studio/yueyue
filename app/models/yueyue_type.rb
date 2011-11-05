class YueyueType < ActiveRecord::Base
  has_and_belongs_to_many :yueyue_type_properties
  has_many :yueyue_type_actions
  has_many :yueyue_objects
end
