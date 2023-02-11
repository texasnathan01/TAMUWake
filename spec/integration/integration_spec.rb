# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a receipt', type: :feature do
  scenario 'valid inputs' do
    visit new_receipt_path
    fill_in "receipt[driver]", with: 'teamteam'
    click_on 'Create Receipt'
    visit receipts_path
    expect(page).to have_content('teamteam')
  end
end

RSpec.describe 'Creating a user', type: :feature do
  scenario 'valid inputs' do
    visit new_user_path
    fill_in "user[firstname]", with: 'team'
    fill_in "user[lastname]", with: 'team'
    fill_in "user[email]", with: 'team'
    click_on 'Create User'
    visit users_path
    expect(page).to have_content('team')
  end
end