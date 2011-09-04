class YueyueObject < ActiveRecord::Base
  belongs_to :yueyue_type
  has_many :yueyue_object_properties
end
