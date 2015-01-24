class AuthorizationsController < ApplicationController

	def failure
		render json: { message: warden.message }, status: :unauthorized
	end

	def create
		warden.authenticate!
		render json: { user: current_user }
	end

	def destroy
		warden.logout
		render head: :success
	end
end
