class User < ActiveRecord::Base
  has_and_belongs_to_many :yueyue_objects, :uniq => true
  has_and_belongs_to_many :groups

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