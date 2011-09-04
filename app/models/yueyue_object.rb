class YueyueObject < ActiveRecord::Base
  belongs_to :yueyue_type
  has_many :yueyue_object_properties
  has_and_belongs_to_many :users, :uniq => true
end
