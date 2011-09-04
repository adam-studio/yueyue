class YueyueTypeProperty < ActiveRecord::Base
    #name属性的约定：method@class
    belongs_to :yueyue_type 
    has_many :yueyue_object_properties
    
    attr_accessor :action_method
    attr_accessor :action_class
end
