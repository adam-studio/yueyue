#encoding: UTF-8

require 'digest/sha1'

class Account < ActiveRecord::Base
  belongs_to :user, :validate => 'true'
  
  attr_accessor :password_confirmation
  
  validate :defined_validate, :on => :create
  
  def defined_validate
    if name.blank?
      errors.add(:base, "帐号不能为空")
    end
    
    if Account.get_by_name_and_type(name, account_type)
      errors.add(:base, "帐号重复")
    end
    
    if account_type == "email" && @password.blank?
      errors.add(:base, "密码不能为空")
    end
    
    if @password != @password_confirmation
      errors.add(:base, "密码不一样")
    end
    
    if errors[:user].any?
      user.errors[:base].each do |msg|
          errors[:base] << msg
      end
    end
  end
  
  def self.get_by_name_and_type(name, type)
    account = self.find(:first, :conditions => ["name = ? and account_type = ?", name, type])
    return account
  end
  
  def self.authenticate(type, name, password)
    account = self.get_by_name_and_type(name, type)
    if account
      expected_password = encrypted_password(password, account.salt)
      if account.hashed_password != expected_password
        account = nil
      end
    end
    return account
  end
  
  # 'password' is a virtual attribute
  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Account.encrypted_password(self.password, self.salt)
  end

  def check_input_password (pwd)
    hashed_password = Account.encrypted_password(pwd, self.salt)
    result = (self.hashed_password == hashed_password)
    return result
  end
  
  private
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
end
