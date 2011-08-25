class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.xml
  	before_filter :authorize, :only => [:create, :new, :join, :quit]
  def join
  	@user = User.find(session[:user_id])
  	@movie = Movie.find(params[:id])  	
  	@movie.users << @user
  	@movie.save
  	redirect_to :action => :show
  end
  
  def quit
  	@user = User.find(session[:user_id])
  	@movie = Movie.find(params[:id])  	
  	@movie.users.delete @user
  	@movie.save
  	redirect_to :action => :show
  end
  
  def index
    if params[:search_str]
      search_str = params[:search_str]
      @movies = Movie.find(:all, :conditions=>["description like ?", "%" + params[:search_str] + "%"])
    else
      @movies = Movie.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])
    
    if @movie
      if @movie.yueyue_owner
        @user = User.find(@movie.yueyue_owner)
      end
    end


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
  	user_id = session[:user_id]
  	if user_id == nil
          redirect_to(:controller => "users", :action => "login", :id=>'1')
          return
    end
        
    @movie = Movie.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])
    @movie.yueyue_owner = session[:user_id]

    respond_to do |format|
      if @movie.save
        format.html { redirect_to(@movie, :notice => 'Movie was successfully created.') }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to(@movie, :notice => 'Movie was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end
end
