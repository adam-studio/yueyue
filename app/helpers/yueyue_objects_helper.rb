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
  
  def render_yueyue_properties
    html_str = ""
    @yueyue_properties.each do |property|
      html_str += <<HTML
      <p>
        <b>#{property.yueyue_type_property.name}:</b>
        #{property.property_value}
      </p>
HTML
    end
    html_str
  end
  
  def render_yueyue_actions
    html_str = ""
    @yueyue_actions.each do |action|
      html_str += <<HTML
      <a href="/yueyue_objects/action/object_id=#{@yueyue_object.id}&action=#{action.name}">#{action.title}</a> |
HTML
    end
    html_str
  end
end
