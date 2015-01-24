class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Token::ControllerMethods
	
	before_action :token_authenticate
	attr_reader :current_user

	def token_authenticate
		@current_user = authenticate_or_request_with_http_token do |token, options|
			user = User.find_for_token_authentication(options[:email])
			user if user && Rack::Utils.secure_compare(user.auth_token, token)
		end
		head :unauthorized unless @current_user
	end

	def current_user
		warden.user
	end

	def warden
		env['warden']
	end

end
