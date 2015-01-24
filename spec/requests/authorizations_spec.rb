require 'rails_helper'

describe "Requesting an authorization token" do
	let!(:user) { FactoryGirl.create(:user) }

	specify 'with valid credentials' do
		post '/authorizations', email: user.email, password: user.password, format: :JSON
		expect(response.status).to eql(201)
		expect(JSON.parse(response.body)["auth_token"]).to eql(user.auth_token)
	end

	specify 'with invalid credentials' do
		post '/authorizations', email: user.email, password: 'password', format: :json
		expect(response.status).to eql(401)
	end

end
