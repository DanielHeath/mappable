module Encryption

  def self.encrypt(value)
    Digest::SHA1.hexdigest(value)
  end

  def self.new_salt
    Salt.generate(12)
  end
  
private
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