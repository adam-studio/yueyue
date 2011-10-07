#encoding: UTF-8

class UsersController < ApplicationController
  before_filter :authorize, :except => [:login, :logout, :new, :create]
    
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create    
    @user = User.new
    account = Account.new(:name=>params[:name], :password=>params[:password], :account_type=>'email')
    @user.accounts << account

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to(:controller=>'yueyue_objects', :action => "index") }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        flash[:notice] ||= "新建用户失败。"
        format.html { render :action => "new" }
        format.xml  { render :xml => flash[:notice], :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    @user.nick_name = params[:nick_name]
    @user.gender = params[:gender]
    @user.city = params[:city]
    @user.status = params[:status]
    @user.description = params[:description] 
    uploaded_io = params[:picture]
    if uploaded_io != nil && uploaded_io.original_filename != ""
      filename = @user.id.to_s + "_" + "profile_image_" + uploaded_io.original_filename.scan(/\.[^\.]+$/)[0]
      File.open(Rails.root.join('public', 'uploads', filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end

      @user.profile_image_url = "/uploads/" + filename
    end

    respond_to do |format|
      if @user.save
        format.html { render :action => "edit" }
        format.xml  { head :ok }
      else
        flash[:notice] ||= "更新用户失败。"
        format.html { render :action => "edit" }
        format.xml  { render :xml => flash[:notice], :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml

  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end

  end

  def login
    if request.post?
      account = Account.authenticate(params[:account_type], params[:account_name], params[:account_password])
      if account
        session[:user_id] = account.user.id
        redirect_to(:controller=>'yueyue_objects', :action => "index")
      else
        flash[:notice] = "错误的用户名或者密码。"
      end
    end

    if request.get? and params[:account_type] != nil
      redirect_to(:controller => 'weibo', :action =>'authorize', :account_type => params[:account_type])
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to(:controller => "yueyue_objects", :action => "index")
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
end