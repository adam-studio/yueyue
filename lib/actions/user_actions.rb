class UserActions
  def self.render_join(yueyue_object_id, action_id)
    "<a href='/yueyue_objects/action/#{yueyue_object_id}&#{action_id}'>join</a>"
  end
  
  def self.process_join(params)
    user = User.find(params[:user_id])
  	yueyue_object = YueyueObject.find(params[:yueyue_object_id])  	
  	yueyue_object.users << user
  	yueyue_object.save
  end
end