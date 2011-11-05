module YueyueTypePropertiesHelper
  def t_builder
    builders = []
    YueyueTypeProperty.get_builders.each do |builder|
      builders << [I18n.t("yueyue_type_properties.#{builder[0]}"), builder[1]]
    end
    builders
  end
end
