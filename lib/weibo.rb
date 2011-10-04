class Weibo
  def self.weibo_types
    %w[sina qq]
  end
  
  def self.write(account_type, text, session)
    
    unless (session["access_token_#{account_type}"])
      return
    end

    client = build_client_class(account_type).load(session["access_token_#{account_type}"]) 
    unless client
      return
    end

    client.add_status text
  end
  
  def self.build_client_class(name)
    eval("OauthChina::#{name.capitalize}")
  end
end