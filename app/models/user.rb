class User < ActiveRecord::Base
  has_and_belongs_to_many :yueyue_objects, :uniq => true
  has_and_belongs_to_many :groups
  has_many :accounts

  def self.create_a_new_user(params)
    ActiveRecord::Base.transaction do
      user = User.new
      account = Account.new
      account.name = params[:account_name]
      account.password = params[:account_password]
      account.account_type = params[:account_type]
      account.request_token = params[:request_token]
      account.request_token_secret = params[:request_token_secret]
      account.access_token = params[:access_token]
      account.access_token_secret = params[:access_token_secret]
      account.user = user

      user.save
      account.save
      
      return user
    end
  end
  
  def self.get_by_account(account_name, account_type)
    account = Account.get_by_name_and_type(account_name, account_type)
    if account
      user = account.user
    else
      user = nil
    end
    return user
  end
  
  def unfinished_yueyue_objects
    unfinished_objects = []
    self.yueyue_objects.each do |yueyue_object|
      if (yueyue_object.yueyue_date >= Date.today.yesterday)
        unfinished_objects << yueyue_object
      end
    end
    unfinished_objects
  end

end