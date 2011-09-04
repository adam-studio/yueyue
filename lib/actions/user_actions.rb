class UserActions
  def self.render_join(yueyue_object_id, action_id, user_id)
    yueyue_object = YueyueObject.find(yueyue_object_id)
    html_str = ""
    if yueyue_object.users.exists?(user_id)
      html_str = "<a href='/yueyue_objects/action/#{yueyue_object_id}&#{action_id}'>unjoin</a>"
    else
      html_str = "<a href='/yueyue_objects/action/#{yueyue_object_id}&#{action_id}'>join</a>"
    end
  end
  
  def self.process_join(params)
    user = User.find(params[:user_id])
  	yueyue_object = YueyueObject.find(params[:yueyue_object_id])
  	if yueyue_object.users.exists?(params[:user_id])	
  	  yueyue_object.users.delete user
	  else
  	  yueyue_object.users << user
	  end
  	yueyue_object.save
  end
end