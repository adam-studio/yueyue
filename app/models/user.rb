require 'digest/sha1'


class User < ActiveRecord::Base
  has_and_belongs_to_many :yueyue_objects, :uniq => true
  has_and_belongs_to_many :groups, :uniq => true

  validates_presence_of     :name
  validates_uniqueness_of   :name

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

  def unfinished_yueyue_objects
    unfinished_objects = []
    self.yueyue_objects.each do |yueyue_object|
      if (yueyue_object.yueyue_date >= Date.today.yesterday)
        unfinished_objects << yueyue_object
      end
    end
    unfinished_objects
  end

  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end


  # 'password' is a virtual attribute
  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def check_input_password (pwd)
    hashed_password = User.encrypted_password(pwd, self.salt)
    result = (self.hashed_password == hashed_password)
    return result
  end



  def self.after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end     



  private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end



  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end




end