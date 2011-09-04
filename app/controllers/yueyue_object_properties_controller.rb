class YueyueObjectPropertiesController < ApplicationController
  # GET /yueyue_object_properties
  # GET /yueyue_object_properties.xml
  def index
    @yueyue_object_properties = YueyueObjectProperty.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yueyue_object_properties }
    end
  end

  # GET /yueyue_object_properties/1
  # GET /yueyue_object_properties/1.xml
  def show
    @yueyue_object_property = YueyueObjectProperty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @yueyue_object_property }
    end
  end

  # GET /yueyue_object_properties/new
  # GET /yueyue_object_properties/new.xml
  def new
    @yueyue_object_property = YueyueObjectProperty.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @yueyue_object_property }
    end
  end

  # GET /yueyue_object_properties/1/edit
  def edit
    @yueyue_object_property = YueyueObjectProperty.find(params[:id])
  end

  # POST /yueyue_object_properties
  # POST /yueyue_object_properties.xml
  def create
    @yueyue_object_property = YueyueObjectProperty.new(params[:yueyue_object_property])

    respond_to do |format|
      if @yueyue_object_property.save
        format.html { redirect_to(@yueyue_object_property, :notice => 'Yueyue object property was successfully created.') }
        format.xml  { render :xml => @yueyue_object_property, :status => :created, :location => @yueyue_object_property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @yueyue_object_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /yueyue_object_properties/1
  # PUT /yueyue_object_properties/1.xml
  def update
    @yueyue_object_property = YueyueObjectProperty.find(params[:id])

    respond_to do |format|
      if @yueyue_object_property.update_attributes(params[:yueyue_object_property])
        format.html { redirect_to(@yueyue_object_property, :notice => 'Yueyue object property was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @yueyue_object_property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /yueyue_object_properties/1
  # DELETE /yueyue_object_properties/1.xml
  def destroy
    @yueyue_object_property = YueyueObjectProperty.find(params[:id])
    @yueyue_object_property.destroy

    respond_to do |format|
      format.html { redirect_to(yueyue_object_properties_url) }
      format.xml  { head :ok }
    end
  end
end
