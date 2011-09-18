class Account < ActiveRecord::Base
  belongs_to :user
  
#  def self.get_or_insert(account_name, account_type)
#    account = find(:first, :conditions => [ "name = ? and type = ?" , account_name, account_type ] )
#    if account == nil
#      account = Account.new
#      account.name = account_name
#      account.type = account_type
#      account.save
#    end
#    return account
#  end
  
end
