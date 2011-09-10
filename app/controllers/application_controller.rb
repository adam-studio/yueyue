require 'net/http'

class ApplicationController < ActionController::Base
 protect_from_forgery
  before_filter :select_city
  
  protected
    def authorize
    	unless User.find_by_id(session[:user_id])
        flash[:notice] = "Please log in"
        redirect_to :controller=>'users',:action=>'login', :id=>'1'
      end
    end
  
    def select_city
      if session[:city] == nil
	      location = lookupLocationByIP request.remote_ip
	      city = nil
	      City.all.each do |search_city|
	      	if location.index(search_city.name) != nil
	      	  city = search_city
	      	  break;
	        end 
      	end
      	
				if city != nil
				  city.rate += 1
          city.save
        else
				  city = City.find(:first, :order => "rate DESC")
				end

        session[:city] = city
      end
    end
   
   private 
def lookupLocationByIP ip
  if ip != nil
    resultXml = Net::HTTP.get URI.parse('http://www.ip138.com/ips.asp?ip=' + ip + '&action=2')
      if resultXml != nil
        result = Iconv.conv("UTF-8", "gb2312", resultXml)
        ss = "\u672C\u7AD9\u4E3B\u6570\u636E\uFF1A"
        addressData = /#{ss}(.+?)(<\/li)/.match(result)
        if addressData != nil
          return addressData[1]
        end
      end  
  end
  return ""
rescue SocketError
  return ""
end  
  
  
end
