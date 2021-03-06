#encoding: UTF-8

class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.xml
  def index
    user = User.find_by_id(session[:user_id])
    @groups = user.groups
    @users = user.get_friends
    if @users && params[:search_str] != nil && params[:search_str] != ""
      search_users = []
      @users.each do |user|
        #user.name.
      end
      @users = @users - search_users
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @accounts = nil
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to(@group, :notice => 'Group was successfully created.') }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])

    if params[:search_users] != nil
      @users = []
      accounts = Account.find(:all, :conditions => ["name like ?", "%" + params[:search_account_name] + "%"], :limit => 5)
      if (accounts)
        for account in accounts
          @users.push(account.user)
        end
      end
      @users.concat(User.find(:all, :conditions => ["nick_name like ?", "%" + params[:search_account_name] + "%"], :limit => 5))
      @users.uniq!
      @users.delete(User.find_by_id(session[:user_id]))
      @users = @users - User.find_by_id(session[:user_id]).get_friends

      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml { render :xml => @users }
      end   
    end
  end
  
  def add_user
    if (params[:id])
      @group = Group.find(params[:id])
    else
      @group = User.find_by_id(session[:user_id]).groups[0]
    end
    user = User.find_by_id(params[:user_id])
    @group.users << user
    
    respond_to do |format| 
      if @group.save
        format.html { redirect_to ({:controller => "groups", :action => "index"}) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def delete_user
    user = User.find_by_id(params[:user_id])
    group = User.find_by_id(session[:user_id]).which_group(user)
    if group
      group.users.delete(user)
    end
    
    respond_to do |format| 
      if group && group.save
        format.html { redirect_to ({:controller => "groups", :action => "index"}) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def invite_someone
    message = Message.new
    message.user = User.find_by_id(params[:user_id])
    message.other_user = User.find_by_id(session[:user_id])
    message.message_type = Message::FRIEND_REQUEST
    
    respond_to do |format| 
      if message.save
        format.html { redirect_to ({:controller => "groups", :action => "index"}) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end
