class Message < ActiveRecord::Base
  SYSTEM_MESSAGES = 0
  FRIEND_REQUEST = 1
  USER_RECEIVED = 2
  USER_SENT = 3
  YUEYUE_MESSAGES = 4
  
  UNREAD = 1
  READED = 0
  
  attr_accessor :other_user_name
  
  belongs_to :user
  belongs_to :other_user, :class_name => "User", :foreign_key => "other_user_id"
end
