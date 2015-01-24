class User < ActiveRecord::Base
  def self.authenticate(email, password)
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email
  	user = find_by(email: email)
  	user if user.password == password
  end
end
