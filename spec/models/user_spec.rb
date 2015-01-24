require 'rails_helper'

RSpec.describe User, :type => :model do

	let(:user) { FactoryGirl.create(:user, password: 'obvious', password_confirmation: 'obvious') }
  
	describe 'when creating a user' do

		it "has an encrypted password with salt" do
		  expect(user.encrypted_password).not_to eql('obvious')
		end

	end

end
