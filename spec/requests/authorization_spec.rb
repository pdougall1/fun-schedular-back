# this is pretty much coppied from Jordan Killback on Frolfr

require 'spec_helper'

describe "Requesting an authorization token" do
	let!(:user) { FactoryFirl.create(:user, password: 'sneaky', password_confirmation: 'sneaky', email: 'coolguy@example.com') }
	let!(:parsed_response) { JSON.parse(response.body) }

	specify 'with valid credentials' do
		post '/authorization', email: user.email, password: user.password, format: :json
		expect(response.status).to eql(200)
		expect(parsed_response["token"]).to eql(user.auth_token)
	end

	specify 'with invalid credentials' do
		post '/authorization', email: user.email, password: 'password', format: :json
		expect(response.status).to eql(400)
	end

end