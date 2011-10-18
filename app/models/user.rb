#encoding: UTF-8

class User < ActiveRecord::Base
  has_and_belongs_to_many :yueyue_objects, :uniq => true
  has_many :accounts
  has_many :messages

  has_many :groups, :foreign_key => "owner_id"
  has_many :groups_users, :class_name => "GroupsUsers"
  has_many :in_groups, :class_name => "Group", :through => :groups_users, :source => :group

  def validate 
    if nick_name.empty?
      errors.add_to_base("昵称不能为空")
    end
  end
  
  def get_friends
    users = []
    self.groups.each do |group|
      users = users + group.users
    end
    return users
  end
  
  def get_accounts_of_friends
    accounts_of_friends = []
    friends = self.get_friends
    friends.each do |friend|
      accounts_of_friends = accounts_of_friends + friend.accounts
    end
    return accounts_of_friends
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

  def get_account_by_type(account_type)
    accounts.find_by_account_type(account_type)
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