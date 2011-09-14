#encoding: UTF-8

class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.xml
  def index
  
    user = User.find_by_id(session[:user_id])
    @groups = user.groups
    if @groups == nil
      @group = Group.new
      @group.name = "未定义"
      @group.save
      user.groups << @group
      user.save
    end
    @users = [ ]
    @groups.each do |group|
    	puts "kkkk"
    	puts group.id
    	if group.users != nil
    	  @users = @users + group.users
      end
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
    user = User.find_by_id("2")
    @group.users << user

    respond_to do |format| 
      if @group.save
        puts "haaaa"
        p @group.users
        p @group.id
        puts "hbbb"
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
