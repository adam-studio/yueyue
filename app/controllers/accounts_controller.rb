#encoding: UTF-8

class AccountsController < ApplicationController
  before_filter :authorize, :except => [:forgot_password, :reset_password, :update_password, :new, :create]
  
  # GET /accounts
  # GET /accounts.xml
  def index
    @accounts = Account.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
    @account = Account.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.xml
  def create
    @account = Account.new(:name=>params[:account_name], :password=>params[:password], :password_confirmation =>params[:password_confirmation], :account_type=>params[:account_type])
    user = User.new
    user.nick_name = params[:nick_name]
    @account.user = user

    respond_to do |format|
      if @account.save
        session[:user_id] = @account.user.id
        format.html { redirect_to(:controller=>'yueyue_objects', :action => "index") }
        format.xml  { render :xml => @account, :status => :created, :location => @account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to(@account, :notice => 'Account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to(accounts_url) }
      format.xml  { head :ok }
    end
  end
 
  def forgot_password
    if request.post?
      account = Account.find(:first, :conditions => ["name = ? and account_type = 'email'", params[:account_name]])
      if account
        account.security_account_id = UUIDTools::UUID.random_create.to_s
        rlt = account.save
        reset_password_url = request.protocol + request.host_with_port + url_for(:only_path => 'true', :action => 'reset_password', :security_account_id => account.security_account_id)
        ResetPasswordMailer.confirm(account.name, reset_password_url).deliver
        @message = "已把链接发送到你的邮箱。"
      else
        @message = "账号不存在"
      end
    end
  end
   
  def reset_password
    if (params[:security_account_id])
      @account = Account.find(:first, :conditions => ["security_account_id = ?", params[:security_account_id]])
    end
    if session[:user_id] && @account == nil
      @account = User.find_by_id(session[:user_id]).get_account_by_type("email")
    end
  end
  
  def update_password
    @account = Account.find(params[:id])
    @account.password = params[:password]
    @account.security_account_id = ""
    
    respond_to do |format| 
      if @account.save
        session[:user_id] = @account.user.id
        format.html { redirect_to ({:controller => "yueyue_objects", :action => "index"}) }
        format.xml  { head :ok }
      else
        format.html { render :action => "reset_password" }
        format.xml  { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end
end
