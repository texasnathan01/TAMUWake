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