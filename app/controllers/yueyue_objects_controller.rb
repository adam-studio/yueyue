class YueyueObjectsController < ApplicationController
  # GET /yueyue_objects
  # GET /yueyue_objects.xml
  def index
    @yueyue_objects = YueyueObject.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yueyue_objects }
    end
  end

  # GET /yueyue_objects/1
  # GET /yueyue_objects/1.xml
  def show
    @yueyue_object = YueyueObject.find(params[:id])
    @yueyue_type = @yueyue_object.yueyue_type
    if (@yueyue_type)
      @yueyue_actions = @yueyue_type.yueyue_type_actions
      #TODO 增加对找不到约约type的异常处理
    end
    
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
    #TODO 按照热门程度对约约主题进行排序
    if @yueyue_types && @yueyue_types.size > 0
      @yueyue_type = @yueyue_types[0]
      @yueyue_properties = @yueyue_type.yueyue_type_properties
      @yueyue_actions = @yueyue_type.yueyue_type_actions
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @yueyue_object }
    end
  end

  # GET /yueyue_objects/1/edit
  def edit
    @yueyue_object = YueyueObject.find(params[:id])
  end

  # POST /yueyue_objects
  # POST /yueyue_objects.xml
  def create
    @yueyue_object = YueyueObject.new(params[:yueyue_object])
    
    #process the properties
    yueyue_object_properties = []
    yueyue_type = YueyueType.find(@yueyue_object.yueyue_type_id)
    if (yueyue_type)
      properties = yueyue_type.yueyue_type_properties
      if (properties)
        properties.each do |property|
          yueyue_object_properties << YueyueObjectProperty.new(#:yueyue_object_id=>yueyue_object.id,
            :yueyue_type_property_id=>property.id, :property_value=>params[property.name])
        end
        @yueyue_object.yueyue_object_properties = yueyue_object_properties
      end
    end

    respond_to do |format|
      if @yueyue_object.save
        format.html { redirect_to(@yueyue_object, :notice => 'Yueyue object was successfully created.') }
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
        format.html { redirect_to(@yueyue_object, :notice => 'Yueyue object was successfully updated.') }
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
end
