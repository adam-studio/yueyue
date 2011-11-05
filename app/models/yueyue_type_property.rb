class YueyueTypeProperty < ActiveRecord::Base
    BUILDER_TEXT_FIELD = 0
    BUILDER_TEXT_AREA = 1
    BUILDER_CHECK_BOX = 2
    
    has_and_belongs_to_many :yueyue_type
    has_many :yueyue_object_properties
    
    attr_accessor :action_method
    attr_accessor :action_class
    
    def self.get_builders
      builders = []
      YueyueTypeProperty.constants.each do |const|
        builders << [const, YueyueTypeProperty.const_get(const)] if const[/^BUILDER_/]
      end
      builders
    end
end