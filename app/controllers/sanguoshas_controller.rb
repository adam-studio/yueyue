class SanguoshasController < ApplicationController
  # GET /sanguoshas
  # GET /sanguoshas.xml
  	before_filter :authorize, :only => [:create, :new, :join, :quit]
  def join
  	@user = User.find(session[:user_id])
  	@sanguosha = Sanguosha.find(params[:id])  	
  	@sanguosha.users << @user
  	@sanguosha.save
  	redirect_to :action => :show
  end
  
  def quit
  	@user = User.find(session[:user_id])
  	@sanguosha = Sanguosha.find(params[:id])  	
  	@sanguosha.users.delete @user
  	@sanguosha.save
  	redirect_to :action => :show
  end
  
  def index
    if params[:search_str]
      search_str = params[:search_str]
      @sanguoshas = Sanguosha.find(:all, :conditions=>["description like ?", "%" + params[:search_str] + "%"])
    else
      @sanguoshas = Sanguosha.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sanguoshas }
    end
  end

  # GET /sanguoshas/1
  # GET /sanguoshas/1.xml
  def show
    @sanguosha = Sanguosha.find(params[:id])
    
    if @sanguosha
      if @sanguosha.yueyue_owner
        @user = User.find(@sanguosha.yueyue_owner)
      end
    end


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sanguosha }
    end
  end

  # GET /sanguoshas/new
  # GET /sanguoshas/new.xml
  def new
  	user_id = session[:user_id]
  	if user_id == nil
          redirect_to(:controller => "users", :action => "login", :id=>'1')
          return
    end
        
    @sanguosha = Sanguosha.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sanguosha }
    end
  end

  # GET /sanguoshas/1/edit
  def edit
    @sanguosha = Sanguosha.find(params[:id])
  end

  # POST /sanguoshas
  # POST /sanguoshas.xml
  def create
    @sanguosha = Sanguosha.new(params[:sanguosha])
    @sanguosha.yueyue_owner = session[:user_id]

    respond_to do |format|
      if @sanguosha.save
        format.html { redirect_to(@sanguosha, :notice => 'Sanguosha was successfully created.') }
        format.xml  { render :xml => @sanguosha, :status => :created, :location => @sanguosha }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sanguosha.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sanguoshas/1
  # PUT /sanguoshas/1.xml
  def update
    @sanguosha = Sanguosha.find(params[:id])

    respond_to do |format|
      if @sanguosha.update_attributes(params[:sanguosha])
        format.html { redirect_to(@sanguosha, :notice => 'Sanguosha was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sanguosha.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sanguoshas/1
  # DELETE /sanguoshas/1.xml
  def destroy
    @sanguosha = Sanguosha.find(params[:id])
    @sanguosha.destroy

    respond_to do |format|
      format.html { redirect_to(sanguoshas_url) }
      format.xml  { head :ok }
    end
  end
end
