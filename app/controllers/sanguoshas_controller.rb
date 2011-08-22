class SanguoshasController < ApplicationController
  # GET /sanguoshas
  # GET /sanguoshas.xml
  def index
    @sanguoshas = Sanguosha.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sanguoshas }
    end
  end

  # GET /sanguoshas/1
  # GET /sanguoshas/1.xml
  def show
    @sanguosha = Sanguosha.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sanguosha }
    end
  end

  # GET /sanguoshas/new
  # GET /sanguoshas/new.xml
  def new
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
