class YueyueTypeActionsController < ApplicationController
  # GET /yueyue_type_actions
  # GET /yueyue_type_actions.xml
  def index
    @yueyue_type_actions = YueyueTypeAction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yueyue_type_actions }
    end
  end

  # GET /yueyue_type_actions/1
  # GET /yueyue_type_actions/1.xml
  def show
    @yueyue_type_action = YueyueTypeAction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @yueyue_type_action }
    end
  end

  # GET /yueyue_type_actions/new
  # GET /yueyue_type_actions/new.xml
  def new
    @yueyue_type_action = YueyueTypeAction.new
    @yueyue_type = YueyueType.find(params[:yueyue_type])
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @yueyue_type_action }
    end
  end

  # GET /yueyue_type_actions/1/edit
  def edit
    @yueyue_type_action = YueyueTypeAction.find(params[:id])
    yueyue_types = YueyueType.all
  end

  # POST /yueyue_type_actions
  # POST /yueyue_type_actions.xml
  def create
    @yueyue_type_action = YueyueTypeAction.new(params[:yueyue_type_action])
    yueyue_type = YueyueType.find(params[:yueyue_type])
    @yueyue_type_action.yueyue_type = yueyue_type

    respond_to do |format|
      if @yueyue_type_action.save
        format.html { redirect_to(@yueyue_type_action, :notice => 'Yueyue type action was successfully created.') }
        format.xml  { render :xml => @yueyue_type_action, :status => :created, :location => @yueyue_type_action }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @yueyue_type_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /yueyue_type_actions/1
  # PUT /yueyue_type_actions/1.xml
  def update
    @yueyue_type_action = YueyueTypeAction.find(params[:id])

    respond_to do |format|
      if @yueyue_type_action.update_attributes(params[:yueyue_type_action])
        format.html { redirect_to(@yueyue_type_action, :notice => 'Yueyue type action was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @yueyue_type_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /yueyue_type_actions/1
  # DELETE /yueyue_type_actions/1.xml
  def destroy
    @yueyue_type_action = YueyueTypeAction.find(params[:id])
    @yueyue_type_action.destroy

    respond_to do |format|
      format.html { redirect_to(yueyue_type_actions_url) }
      format.xml  { head :ok }
    end
  end
end
