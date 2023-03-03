# location: spec/feature/integration_spec.rb
require 'rails_helper'

def login
  Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  visit root_path
  click_link 'Sign in with Google'
end


setup do
  OmniAuth.config.test_mode = true
  Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
  Rails.application.env_config["omniauth.auth"]  = google_oauth2_mock
end

RSpec.describe 'Creating a receipt', type: :feature do
  scenario 'valid inputs' do
    login
    visit new_receipt_path
    fill_in "receipt[user_id]", with: 123
    click_on 'Create Receipt'
    visit receipts_path
    expect(page).to have_content('Receipt')
  end
end

RSpec.describe 'Creating a user', type: :feature do
  scenario 'valid inputs' do
    login
    visit new_user_path
    fill_in "user[firstname]", with: 'team'
    fill_in "user[lastname]", with: 'team'
    fill_in "user[email]", with: 'team'
    click_on 'Create User'
    visit users_path
    expect(page).to have_content('team')
  end

  private

    def google_oauth2_mock
        OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: "google_oauth2",
        uid: "12345678910",
        info: { 
            email: "fakeemail@gmail-fake.com",
            first_name: "David",
            last_name: "McDonald"
        },
        credentials: {
            token: "abcdefgh12345",
            refresh_token: "12345abcdefgh",
            expires_at: DateTime.now
        }
      })
  end
end