#encoding: UTF-8

module OauthChina
  class Sina < OauthChina::OAuth
    def get_account_name
      response = self.get("/account/verify_credentials.json")
      if response != nil && response.code == '200'
        data = ActiveSupport::JSON.decode response.body
        data["id"]
      else
        nil
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
    account_name = client.get_account_name
    account = Account.get_by_name_and_type(account_name, params[:account_type])
    puts "abc"
    p account
    if account != nil
      session[:user_id] = account.user.id
      redirect_to(:controller=>'yueyue_objects', :action => "index")
    else
      new_user_params = Hash.new
      new_user_params[:account_type] = params[:account_type]
      new_user_params[:account_name] = account_name
      client_dump = client.dump 
      new_user_params[:request_token] = client_dump[:request_token]
      new_user_params[:request_token_secret] = client_dump[:request_token_secret]
      new_user_params[:access_token] = client_dump[:access_token]
      new_user_params[:access_token_secret] = client_dump[:access_token_secret]
      
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
