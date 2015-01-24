class AuthorizationsController < ApplicationController
	skip_filter :token_authenticate

	def failure
		render json: { message: warden.message }, status: :unauthorized
	end

	def create
		user = warden.authenticate!
		if user
			render json: { auth_token: user.auth_token }, status: :created
		else
			head :unprocessable_entity
		end
	end
end
