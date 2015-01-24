Rails.application.config.middleware.use Warden::Manager do |manager|
	manager.default_strategies :password
	manager.failure_app = lambda { |env| AuthorizationsController.action(:failure).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.get(id)
end

Warden::Strategies.add(:password) do

  def valid?
    params["email"] || params["password"]
  end

  def authenticate!
    u = User.authenticate(params["email"], params["password"])
    u ? success!(u) : fail!
  end
end