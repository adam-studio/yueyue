require 'actions/user_actions'

module YueyueObjectsHelper
  def edit_yueyue_properties
    html_str = ""
    @yueyue_properties.each do |property|
      property_value = ""
      if @yueyue_object_properties
        @yueyue_object_properties.each do |object_property|
          if object_property.yueyue_type_property.id == property.id
            property_value = object_property.property_value
            break
          end
        end

      end
      html_str += <<HTML
      <div class="field">
      <label for="yueyue_property_#{property.id}">#{property.name}</label><br /> 
      <input id="yueyue_property_#{property.id}" name="yueyue_property_#{property.id}" value="#{property_value}" size="30" type="text" />
      </div>
HTML
    end
    html_str
  end

  def render_yueyue_properties
    html_str = ""
    @yueyue_properties.each do |property|
      html_str += <<HTML
      <div class='bt'>
        <span class='t1'>#{property.yueyue_type_property.name}:
        </span>
        #{property.property_value}
      </div>
HTML
    end
    html_str
  end

  # TODO get to post
  def render_yueyue_actions
    html_str = ""
    @yueyue_actions.each do |action|
      # action class and method
      action_method_name, action_class_name = action.name.split('@')
      render_method_name = "render_#{action_method_name}"
      action_class = Object.const_get(action_class_name)
      html_str += action_class.send(render_method_name, @yueyue_object.id, action.id, session[:user_id])
    end
    html_str
  end
end
