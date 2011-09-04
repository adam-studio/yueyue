class UserActions
  def self.render_join(yueyue_object_id, user_id)
    "<a href='/yueyue_objects/action/object_id=#{yueyue_object_id}&action=join&user_id=#{user_id}'>join</a>"
  end
  
  def self.process_join
    
  end
end