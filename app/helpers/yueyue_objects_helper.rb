require 'actions/user_actions'

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
    UserActions.render_join(@yueyue_object.id, "chengbin")
    html_str = ""
    @yueyue_actions.each do |action|
      # 获取action类与方法
      action_method_name, action_class_name = action.name.split('@')
      render_method_name = "render_#{action_method_name}"
      action_class = Object.const_get(action_class_name)
      #TODO 加入真正的userid
      html_str += action_class.send(render_method_name, @yueyue_object.id, "chengbin")
    end
    html_str
  end
end
