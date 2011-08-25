class TopicController < ApplicationController
  def index
    @yueyues = {:sanguoshas => Sanguosha.all, :movies => Movie.all}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @yueyues }
    end
  end
end
