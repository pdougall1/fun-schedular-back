class User < ActiveRecord::Base
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :name
  validates_uniqueness_of :email

  before_create :set_auth_token, :downcase_email
	before_save :encrypt_password

	def downcase_email
		email = email.downcase if email
	end

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

  def self.find_for_token_authentication(email)
    where('lower(email) = lower(?)', email).first
  end

	def match_password(password)
	  encrypted_password == BCrypt::Engine.hash_secret(password, salt)
	end

  private

  def set_auth_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end
end
