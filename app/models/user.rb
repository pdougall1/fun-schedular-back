class User < ActiveRecord::Base
  def self.authenticate(email, password)
  	user = find_by(email: email)
  	user if user.password == password
  end
end
