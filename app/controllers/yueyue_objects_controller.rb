class YueyueObjectsController < ApplicationController
  # GET /yueyue_objects
  # GET /yueyue_objects.xml
  before_filter :authorize, :except => [:index, :show]
  def index
    condition_fixed = "yueyue_date >= date('now')"
    if params[:search_str]
      conditions = [condition_fixed + " and title like ?", "%" + params[:search_str] + "%"]
      @search_str = params[:search_str]
    else
      conditions = condition_fixed
    end
    
    if params[:type]
      @yueyue_objects = YueyueObject.find(:all, :order=>:created_at, :limit=>20, :conditions=>conditions)
    else
      @yueyue_objects = YueyueObject.find(:all, :order=>:created_at, :limit=>10, :conditions=>conditions)
      @hot_yueyue_objects = YueyueObject.find(:all, :order=>"rate desc", :limit=>10, :conditions=>conditions)
    end
    @yueyue_types = YueyueType.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yueyue_objects }
    end
  end

  #GET /yueyue_objects/list
  #GET /yueyue_objects/list.xml
  def list
    condition_fixed = "yueyue_date >= date('now')"
    if params[:search_str]
      conditions = [condition_fixed + " and title like ?", "%" + params[:search_str] + "%"]
      @search_str = params[:search_str]
    else
      conditions = condition_fixed
    end
    @yueyue_objects = YueyueObject.paginate(:page=>params[:page], :per_page=>20, :order=>params[:order], :conditions=>conditions)
  end

  #GET /yueyue_objects/home
  #GET /yueyue_objects/home.xml
  def home
    condition_fixed = "yueyue_date >= date('now') and owner_id = ?"
    if params[:search_str]
      conditions = [condition_fixed + " and title like ?", session[:user_id], "%" + params[:search_str] + "%"]
      @search_str = params[:search_str]
    else
      conditions = [condition_fixed, session[:user_id]]
    end
    @created_yueyue_objects = YueyueObject.find(:all, :order=>:created_at, 
      :limit=>10, :conditions=>conditions)
    
    user = User.find(session[:user_id])
    @joined_yueyue_objects = user.unfinished_yueyue_objects
  end

  # GET /yueyue_objects/1
  # GET /yueyue_objects/1.xml
  def show
    @yueyue_object = YueyueObject.find(params[:id])
    if @yueyue_object.rate
      @yueyue_object.rate += 1
    else
      @yueyue_object.rate = 1
    end
    @yueyue_object.save
    @yueyue_properties = @yueyue_object.yueyue_object_properties

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @yueyue_object }
    end
  end

  # GET /yueyue_objects/new
  # GET /yueyue_objects/new.xml
  def new
    @yueyue_object = YueyueObject.new
    @yueyue_types = YueyueType.all

    if @yueyue_types && @yueyue_types.size > 0
      if params[:id]
        @yueyue_type = YueyueType.find(params[:id])
      else
        @yueyue_type = @yueyue_types[0]
      end
      @yueyue_properties = @yueyue_type.yueyue_type_properties
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @yueyue_object }
    end
  end

  # GET /yueyue_objects/1/edit
  def edit
    @yueyue_object = YueyueObject.find(params[:id])
    @yueyue_types = YueyueType.all
    @yueyue_type = @yueyue_object.yueyue_type
    @yueyue_properties = @yueyue_type.yueyue_type_properties
    @yueyue_object_properties = @yueyue_object.yueyue_object_properties
  end

  # POST /yueyue_objects
  # POST /yueyue_objects.xml
  def create
    user = User.find(session[:user_id])
    @yueyue_object = YueyueObject.new(params[:yueyue_object])
    @yueyue_object.owner = user
    @yueyue_object.rate = 0

    #process the properties
    yueyue_object_properties = []
    yueyue_type = @yueyue_object.yueyue_type
    if (yueyue_type)
      properties = yueyue_type.yueyue_type_properties
      if (properties)
        properties.each do |property|
          yueyue_object_properties << YueyueObjectProperty.new(:yueyue_object_id=>@yueyue_object.id,
          :yueyue_type_property_id=>property.id, :property_value=>params["yueyue_property_#{property.id}"])
        end
        @yueyue_object.yueyue_object_properties = yueyue_object_properties
      end
    end

    respond_to do |format|
      if @yueyue_object.save
        # send weibo
        url = "#{request.protocol}#{request.host_with_port}/yueyue_objects/#{@yueyue_object.id}"
        send_weibo user, params[:weibo_types], @yueyue_object.title, url
        format.html { redirect_to(@yueyue_object, :notice => I18n.t('yueyue_objects.created')) }
        format.xml  { render :xml => @yueyue_object, :status => :created, :location => @yueyue_object }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @yueyue_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /yueyue_objects/1
  # PUT /yueyue_objects/1.xml
  def update
    @yueyue_object = YueyueObject.find(params[:id])

    respond_to do |format|
      if @yueyue_object.update_attributes(params[:yueyue_object])
        format.html { redirect_to(@yueyue_object, :notice => I18n.t('yueyue_objects.updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @yueyue_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /yueyue_objects/1
  # DELETE /yueyue_objects/1.xml
  def destroy
    @yueyue_object = YueyueObject.find(params[:id])
    @yueyue_object.destroy

    respond_to do |format|
      format.html { redirect_to(yueyue_objects_url) }
      format.xml  { head :ok }
    end
  end
  
  def join
    user = User.find(session[:user_id])
  	yueyue_object = YueyueObject.find(params[:id])
  	if yueyue_object.users.exists?(params[:user_id])	
  	  yueyue_object.users.delete user
	  else
  	  yueyue_object.users << user
	  end
  	yueyue_object.save
  	redirect_to yueyue_object
  end
  
  private
  def send_weibo(user, account_types, text, url)
    unless account_types
      return
    end
    account_types.each do |account_type|
      account = user.get_account_by_type account_type
      if (account)
        Weibo.write account_type, text, session, url
      else
        # redirect to weibo authorize
      end
    end
  end
end
