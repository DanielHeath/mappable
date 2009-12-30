class User < ActiveRecord::Base
  validates_presence_of :email, :encrypted_password
  has_many :maps
  has_many :entities
  
  def password=(pw)
    self.salt = self.class.new_salt
    self.encrypted_password = encrypt(pw)
  end

  def self.login_or_signup(args)
    current = User.find_by_email(args[:email]) || User.create!(args)
    current.encrypted_password == current.encrypt(args[:password]) ? current : nil
  end
  
  def encrypt(password)
    Digest::SHA1.hexdigest("#{salt}--#{password}--")
  end
  
private

  def self.new_salt
    Salt.generate(12)
  end
  
  module Salt
    CHARS = ['.', '/', '0'..'9', 'A'..'Z', 'a'..'z'].collect do |x|
      x.to_a
    end.flatten

    def self.generate(length)
      salt = ""
      length.times {salt << CHARS[rand(CHARS.length)]}
      salt
    end
  end

end
