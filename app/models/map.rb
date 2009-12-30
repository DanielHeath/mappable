class Map < ActiveRecord::Base
  validates_uniqueness_of :name

  attr_accessor :portrait_use
  validates_acceptance_of :portrait_use, :on => :create

  has_many :entities
  belongs_to :user


  def gm_is(usr)
    self.user == usr
  end
  
end
