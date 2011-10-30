class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    @system_messages_count = count_unread_messages_by_type Message::SYSTEM_MESSAGES
    @friends_requests_count = count_unread_messages_by_type Message::FRIEND_REQUEST
    @user_messages_count = count_unread_messages_by_type Message::USER_RECEIVED

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  def list
    @messages = Message.paginate(:page=>params[:page], :per_page=>20, :order=>"created_at desc", 
    :conditions=>"user_id=#{session[:user_id]} and message_type=#{params[:message_type]}")
    @message_type = params[:message_type].to_i
    @messages.each do |message|
      if @message_type == Message::SYSTEM_MESSAGES
        other_user_name = I18n.t "messages.system"
      else
        other_user_name = message.other_user.nick_name
      end
      
      if @message_type != Message::USER_SENT && message.status == 1
        other_user_name += "(#{I18n.t("messages.readed")})"
      end
      message.other_user_name = other_user_name
      
      if @message_type == Message::FRIEND_REQUEST
        #message.content = I18n.t "messages.friends_request"
      end
      message.update_attributes(:status=>1)
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    send_message = Message.new(params[:message])
    send_message.status = 1
    send_message.other_user_id = params[:to_user]
    send_message.message_type = Message::USER_SENT
    send_message.user_id = session[:user_id]
    
    receive_message = Message.new(params[:message])
    receive_message.status = 0
    receive_message.other_user_id = session[:user_id]
    receive_message.message_type = Message::USER_RECEIVED
    receive_message.user_id = params[:to_user]
    
    goto_url = session[:after_send_message_url]
    session[:after_send_message_url] = nil
    
    respond_to do |format|
      if send_message.save && receive_message.save
        format.html { redirect_to(goto_url) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => receive_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end

  private
  def count_unread_messages_by_type(message_type)
    Message.count(:conditions=>"user_id = #{session[:user_id]} and status = 0 and message_type = #{message_type}")
  end
end
