class Weibo
  def self.weibo_types
    %w[sina qq]
  end
  
  def self.write(account_type, text, session, url)
    unless (session["access_token_#{account_type}"])
      return
    end
    client = build_client_class(account_type).load(:access_token=>session["access_token_#{account_type}"], 
      :access_token_secret=>session["access_token_secret_#{account_type}"]) 
    unless client
      return
    end
    weibo_content = "#{text} #{I18n.t "weibo.join"}#{url} #{I18n.t "weibo.comefrom"}"
    client.add_status weibo_content
  end
  
  def self.build_client_class(name)
    eval("OauthChina::#{name.capitalize}")
  end
end