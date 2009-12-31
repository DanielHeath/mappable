class User < ActiveRecord::Base
  include Encryption
  validates_presence_of :email, :encrypted_password
  has_many :maps
  has_many :entities
  
  def password=(pw)
    self.salt = Encryption.new_salt
    self.encrypted_password = encrypt(pw)
  end

  def self.login_or_signup(args)
    current = User.find_by_email(args[:email]) || User.create!(args)
    current.encrypted_password == current.encrypt(args[:password]) ? current : nil
  end

private

  def encrypt(password)
    Encryption.encrypt("#{salt}--#{password}--")
  end

end
