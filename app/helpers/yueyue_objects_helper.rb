module YueyueObjectsHelper
  def edit_yueyue_properties
    html_str = ""
    @yueyue_properties.each do |property|
      html_str += <<HTML
      <div class="field">
          <label for="yueyue_object_#{property.name}">#{property.name}</label><br /> 
          <input id="yueyue_object_#{property.name}" name="#{property.name}" size="30" type="text" />
        </div>
HTML
    end
    html_str
  end
end
