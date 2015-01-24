class User < ActiveRecord::Base
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email

	before_save :encrypt_password

	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	  end
	end

  def self.authenticate(email, login_password)
  	user = find_by(email: email)
	  if user && user.match_password(login_password)
	    return user
	  else
	    return false
	  end
  end

	def match_password(password)
	  encrypted_password == BCrypt::Engine.hash_secret(password, salt)
	end
end
