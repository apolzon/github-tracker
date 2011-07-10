class User < ActiveRecord::Base
  has_many :projects
  has_secure_password
  attr_accessor :password_confirmation

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => {:on => :create}
  validates :password_confirmation, :presence => {:on => :create}
end
