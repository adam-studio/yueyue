#encoding: UTF-8

module OauthChina
  class Sina < OauthChina::OAuth
    @@provinces = {}
    def get_city_name_by_province_id_and_city_id(province, city)
      if @@provinces.empty?
        response = self.get("/provinces.xml")
        if response != nil && response.code == '200'
          p response.body
          @@provinces = ActiveSupport::JSON.decode response.body
          p @@provinces
        end
      end
      puts "bbbb"
      @@provinces["provinces"].each {|key, value| puts "#{key} is #{value}" }
      return @@provinces[province, city]
    end
    
    def get_account_info
      response = self.get("/account/verify_credentials.json")
      if response != nil && response.code == '200'
        data = ActiveSupport::JSON.decode response.body
        account_info = Hash.new
        account_info[:account_name] = data["id"]
        account_info[:nick_name] = data["screen_name"]
        account_info[:profile_image_url] = data["profile_image_url"]
        account_info[:gender] = data["gender"]
        account_info[:city] = get_city_name_by_province_id_and_city_id(data["province"], data["city"])
        return account_info
      else
        return nil
      end
    end
  end
end


class WeiboController < ApplicationController
  def authorize
    if params[:account_type] != nil
      client = build_client_class(params[:account_type]).new
      url = request.protocol + request.host_with_port
      callback_url = url + url_for(:only_path => 'true', :action => 'callback', :account_type => params[:account_type])
      client.config["url"] = url
      client.config["callback"] = callback_url
      Rails.cache.write(build_oauth_token_key(client.name, client.oauth_token), client.dump)  
      redirect_to client.authorize_url
    end
  end

  # 用户校验后页面，捆绑用户token
  def callback
    client = build_client_class(params[:account_type]).load(Rails.cache.read(build_oauth_token_key(params[:account_type], params[:oauth_token])))
    client.authorize(:oauth_verifier => params[:oauth_verifier]) 
    account_info = client.get_account_info
    account = Account.get_by_name_and_type(account_info[:account_name], params[:account_type])
    if account != nil
      session[:user_id] = account.user.id
      redirect_to(:controller=>'yueyue_objects', :action => "index")
    else
      new_user_params = Hash.new
      new_user_params[:account_type] = params[:account_type]
      new_user_params.merge(account_info)
      p account_info
      client_dump = client.dump 
      new_user_params[:request_token] = client_dump[:request_token]
      new_user_params[:request_token_secret] = client_dump[:request_token_secret]
      new_user_params[:access_token] = client_dump[:access_token]
      new_user_params[:access_token_secret] = client_dump[:access_token_secret]
      
      p new_user_params
      
      user = User.create_a_new_user(new_user_params)
      
      session[:user_id] = user.id
      redirect_to(:controller=>'yueyue_objects', :action => "index") 
      
      end
  end

  # 发送内容到微博
  # params:
  # => type:微博类型（qq,sina）
  # => weibo_text:微博内容
  # => after_url:发送成功后返回的URL
  def write
    unless (session["access_token_#{params[:type]}"])
      return
    end

    client = build_client_class(params[:type]).load(session["access_token_#{params[:type]}"]) 
    unless client
      return
    end

    client.add_status params[:weibo_text]
    redirect_to params[:after_url]
  end


  private
  def build_oauth_token_key(name, oauth_token)  
    [name, oauth_token].join("_")  
  end

  def build_client_class(name)
    eval("OauthChina::#{name.capitalize}")
  end
end
