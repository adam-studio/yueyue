class YueyueTypePropertiesController < ApplicationController
  # GET /yueyue_type_properties
  # GET /yueyue_type_properties.xml
  def index
    @yueyue_type_properties = YueyueTypeProperty.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yueyue_type_properties }
    end
  end

  # GET /yueyue_type_properties/1
  # GET /yueyue_type_properties/1.xml
  def show
    @yueyue_type_property = YueyueTypeProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @yueyue_type_property }
    end
  end

  # GET /yueyue_type_properties/new
  # GET /yueyue_type_properties/new.xml
  def new
    @yueyue_type_property = YueyueTypeProperty.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @yueyue_type_property }
    end
  end

  # GET /yueyue_type_properties/1/edit
  def edit
    @yueyue_type_property = YueyueTypeProperty.find(params[:id])
    @yueyue_types = YueyueType.all
  end

  # POST /yueyue_type_properties
  # POST /yueyue_type_properties.xml
  def create
    @yueyue_type_property = YueyueTypeProperty.new(params[:yueyue_type_property])
    respond_to do |format|
      if @yueyue_type_property.save
        format.html { redirect_to(yueyue_type_properties_path, :notice => 'Yueyue type property was successfully created.') }
        format.xml  { render :xml => @yueyue_type_property, :status => :created, :location => @yueyue_type_property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @yueyue_type_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /yueyue_type_properties/1
  # PUT /yueyue_type_properties/1.xml
  def update
    @yueyue_type_property = YueyueTypeProperty.find(params[:id])

    respond_to do |format|
      if @yueyue_type_property.update_attributes(params[:yueyue_type_property])
        format.html { redirect_to(@yueyue_type_property, :notice => 'Yueyue type property was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @yueyue_type_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /yueyue_type_properties/1
  # DELETE /yueyue_type_properties/1.xml
  def destroy
    @yueyue_type_property = YueyueTypeProperty.find(params[:id])
    @yueyue_type_property.destroy

    respond_to do |format|
      format.html { redirect_to(yueyue_type_properties_url) }
      format.xml  { head :ok }
    end
  end
end
