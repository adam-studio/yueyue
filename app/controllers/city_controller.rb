#coding: utf-8

class CityController < ApplicationController
after_filter :remember_url, :only => []
  def index
    @cities = City.find(:all, :limit => 10, :order => "rate DESC")
    
    @Alphabet = ('A'..'Z')
    
    @return_url = session[:original_url_before_change_city] || {:controller => 'yueyue_objects', :action => 'index' }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cities }
    end
  end
  
  def change_city
    city = City.find_by_id(params[:id])
    if city != nil
      session[:city] = city
      city.rate += 1
      city.save
    end
    redirect_url = session[:original_url_before_change_city] || {:controller => 'yueyue_objects', :action => 'index' }
  redirect_to redirect_url
  end
  
  def index_by_letter
    @cities = City.find(:all, :conditions => ["pinyin like ?", params[:id] + "%"], :order => "rate DESC")
    
      respond_to do |format|
      format.html # index_by_letter.html.erb
      format.xml  { render :xml => @cities }
    end
  end
  
  def search
  city = City.find(:first, :conditions => ["name = ? or area_code = ?", params[:q], params[:q]])
    if city != nil
      redirect_to :action => "change_city", :id => city
    else
      session[:notice] = "对不起，没有找到该城市。"
      redirect_to :controller => "city", :action => "index"
    end
  end
  
end
