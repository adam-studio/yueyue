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
      else
        if property.default_value && property.default_value.length > 0
          next
        end
      end
      
      builder_str = case property.builder
                        when YueyueTypeProperty::BUILDER_TEXT_FIELD
                          build_text(property.id, property_value)
                        when YueyueTypeProperty::BUILDER_TEXT_AREA
                          build_text_area(property.id, property_value)
                        when YueyueTypeProperty::BUILDER_CHECK_BOX
                          build_check_box(property.id, property_value)
                        else
                          ""
      end
      
      html_str += <<HTML
      <div class="field">
      <label for="yueyue_property_#{property.id}">#{property.name}</label><br /> 
      #{builder_str}
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
  
  def render_nav
    if @yueyue_object.users.exists?(session[:user_id])
    	join_title = I18n.t 'yueyue_type_actions.quit_join'
    	group_send = " <a href='/send_msg/#{Message::YUEYUE_MESSAGES}/#{@yueyue_object.id}'>#{I18n.t 'yueyue_objects.group_send'}</a> |"
  	else
  	  join_title = I18n.t 'yueyue_type_actions.join'
    end

    if session[:user_id] == @yueyue_object.owner.id
      html_str = "<a href='/yueyue_objects/#{@yueyue_object.id}/edit'>#{I18n.t 'helpers.submit.update'}</a> |"
    else
      html_str = "<a href='/yueyue_objects/join/#{@yueyue_object.id}'>#{join_title}</a> |"
    end
    html_str += group_send if group_send
    
    html_str + " <a href='/yueyue_objects'>#{I18n.t 'helpers.quit'}</a>"
  end
  
  private
  def build_text(id, value)
    "<input id='#{id}' name='#{id}' value='#{value}' size='30' type='text' value='#{value}' />"
  end
  
  def build_text_area(id, value)
    "<textarea cols='25' id='#{id}' name='#{id}' rows='4'>#{value}</textarea>"
  end
  
  def build_check_box(id, value)
    "<input checked='#{value}' id='#{id}' name='#{id}' type='checkbox' />"
  end
end
