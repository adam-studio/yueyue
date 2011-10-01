#encoding: UTF-8

class WeiboController < ApplicationController
  def authorize
    if params[:account_type] != nil
      client = build_client_class(params[:account_type]).new
      Rails.cache.write(build_oauth_token_key(client.name, client.oauth_token), client.dump)  
      redirect_to client.authorize_url 
	end
  end

  # 用户校验后页面，捆绑用户token
  def callback
    client = build_client_class(params[:acount_type]).load(Rails.cache.read(build_oauth_token_key(params[:acount_type], params[:oauth_token])))
    client.authorize(:oauth_verifier => params[:oauth_verifier])  

    results = client.dump  

    if results[:access_token] && results[:access_token_secret]
      account Account.get_by_3rd_account(params[:account_type], results[:access_token], results[:access_token_secret])
	  if account?
	    session[:user_id] = account.user.id
	    redirect_to(:controller=>'yueyue_objects', :action => "index")
      else
		# 新用户
		redirect_to(:controller=>'users', :action => 'create', :method => 'post', :account_type => params[:account_type], :account_name =>    :access_token => results[:access_token], :access_token_secret => results[:access_token_secret])
    else  
      flash.now[:notice] = "错误的用户名或者密码。"
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
