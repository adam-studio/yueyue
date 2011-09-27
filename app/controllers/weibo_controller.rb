class WeiboController < ApplicationController
  # 用户微博认证，登录或者用户后期绑定微博时使用
  def new 
    client = build_client_class(params[:type]).new
    authorize_url = client.authorize_url  
    Rails.cache.write(build_oauth_token_key(client.name, client.oauth_token), client.dump)  
    redirect_to authorize_url
  end

  # 用户校验后页面，捆绑用户token
  def callback
    client = build_client_class(params[:type]).load(Rails.cache.read(build_oauth_token_key(params[:type], params[:oauth_token])))
    client.authorize(:oauth_verifier => params[:oauth_verifier])  

    results = client.dump  

    if results[:access_token] && results[:access_token_secret]
      session["access_token_#{params[:type]}"] = {:access_token=>results[:access_token], :access_token_secret=>results[:access_token_secret]}
      #to 林海：在这里把access token and access token secret存到db
      #下次登录的时候:  
      #session["access_token_#{params[:type]}"] = {:access_token=>results[:access_token], :access_token_secret=>results[:access_token_secret]}
      flash[:notice] = "success!"  
    else  
      flash[:notice] = "failed!"  
    end  
    #redirect_to 登录后或者绑定页面，没想好
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
  
  def test_it
    
  end

  private
  def build_oauth_token_key(name, oauth_token)  
    [name, oauth_token].join("_")  
  end
  
  def build_client_class(name)
    eval("OauthChina::#{name.capitalize}")
  end
end
