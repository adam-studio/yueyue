class WeiboController < ApplicationController
  def request_token

    @request_token = consumer.get_request_token
    session[:request_token] = @request_token.token
    session[:request_token_secret] = @request_token.secret
    redirect_to @request_token.authorize_url(:oauth_callback => 'http://localhost:3000/weibo/access_token') 
  end

  def access_token
    request_token = OAuth::RequestToken.new(
    consumer,
    session[:request_token],
    session[:request_token_secret]
    )
    access_token = request_token.get_access_token(:oauth_verifier=>params["oauth_verifier"])
    session[:access_token] = access_token.token
    session[:access_token_secret] = access_token.secret
  end

  def send_message
    access_token = OAuth::AccessToken.new(consumer, session[:access_token],session[:access_token_secret])
    url="http://api.t.sina.com.cn/statuses/update.xml"
    message="should not see me"
    response = access_token.request(:post, url, :status=>message)
  end
  
  #private
  def consumer
    ::OAuth::Consumer.new("2170727488", "2998adc7ce90863096ece093ff095f6b", :site => "http://api.t.sina.com.cn")
  end
end
