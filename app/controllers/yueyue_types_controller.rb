class YueyueTypesController < ApplicationController
  # GET /yueyue_types
  # GET /yueyue_types.xml
  def index
    @yueyue_types = YueyueType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yueyue_types }
    end
  end

  # GET /yueyue_types/1
  # GET /yueyue_types/1.xml
  def show
    @yueyue_type = YueyueType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @yueyue_type }
    end
  end

  # GET /yueyue_types/new
  # GET /yueyue_types/new.xml
  def new
    @yueyue_type = YueyueType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @yueyue_type }
    end
  end

  # GET /yueyue_types/1/edit
  def edit
    @yueyue_type = YueyueType.find(params[:id])
  end

  # POST /yueyue_types
  # POST /yueyue_types.xml
  def create
    @yueyue_type = YueyueType.new(params[:yueyue_type])

    respond_to do |format|
      chifan = YueyueTypeAction.new
      chifan.name = "chifan@My_ction"
      chifan.title = "chi fan le"
      
      chifan_prop = YueyueTypeProperty.new
      chifan_prop.name = "chifan@my_class"
      @yueyue_type.yueyue_type_actions << chifan
      @yueyue_type.yueyue_type_properties << chifan_prop
      if @yueyue_type.save
        format.html { redirect_to(@yueyue_type, :notice => 'Yueyue type was successfully created.') }
        format.xml  { render :xml => @yueyue_type, :status => :created, :location => @yueyue_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @yueyue_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /yueyue_types/1
  # PUT /yueyue_types/1.xml
  def update
    @yueyue_type = YueyueType.find(params[:id])

    respond_to do |format|
      if @yueyue_type.update_attributes(params[:yueyue_type])
        format.html { redirect_to(@yueyue_type, :notice => 'Yueyue type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @yueyue_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /yueyue_types/1
  # DELETE /yueyue_types/1.xml
  def destroy
    @yueyue_type = YueyueType.find(params[:id])
    @yueyue_type.destroy

    respond_to do |format|
      format.html { redirect_to(yueyue_types_url) }
      format.xml  { head :ok }
    end
  end
end