# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Using Account Page and Tools', type: :feature do

  let(:admin) {Admin.create(email: "chrispasala@tamu.edu", first_name: "first", last_name: "last",role_id: -2)}

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
  end

  scenario 'visiting account page' do
    visit accounts_path
    expect(page).to have_content('chrispasala@tamu.edu')
  end

  scenario 'visiting account page and editing user info' do
    visit edit_admin_path(admin.id)
    fill_in "admin[first_name]", with: "new_name"
    click_on 'Update Account Info'
    expect(page).to have_content('new_name')
  end

end