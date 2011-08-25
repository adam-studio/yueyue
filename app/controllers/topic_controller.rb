class TopicController < ApplicationController
  def index
    if params[:search_str]
      search_str = params[:search_str]
      @yueyues = {:sanguoshas => Sanguosha.find(:all, :conditions=>["description like ?", "%" + params[:search_str] + "%"]),
        :movies => Movie.find(:all, :conditions=>["description like ?", "%" + params[:search_str] + "%"])}
    else
      @yueyues = {:sanguoshas => Sanguosha.all, :movies => Movie.all}
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yueyues }
    end
  end

end
