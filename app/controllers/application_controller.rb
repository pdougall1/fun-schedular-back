class ApplicationController < ActionController::API

	def current_user
		warden.user
	end

	def warden
		env['warden']
	end

end
