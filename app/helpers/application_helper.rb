module ApplicationHelper
  def render_menu
    
  end
  
  def count_unread_message
    Message.count(:conditions=>"user_id = #{session[:user_id]} and status = #{Message::UNREAD}")
  end
end
