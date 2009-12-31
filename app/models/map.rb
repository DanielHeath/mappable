class Map < ActiveRecord::Base

  attr_accessor :portrait_use
  has_many :entities
  belongs_to :user
  
  validates_uniqueness_of :name
  validates_acceptance_of :portrait_use, :on => :create

  def gm_is(usr)
    self.user == usr
  end
  
  def secret_key
    Encryption.encrypt("--#{user_id}-#{name}-#{image_url}-#{width}-#{height}")
  end
  
end
