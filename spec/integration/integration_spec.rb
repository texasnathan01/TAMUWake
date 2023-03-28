# location: spec/feature/integration_spec.rb
require 'rails_helper'



<<<<<<< HEAD
RSpec.describe 'Account Pages', type: :feature do
  let(:admin) {Admin.create(email: "chrispasala@tamu.edu")}
  let(:user) {User.create(email: "chrispasala@tamu.edu", firstname: "first", lastname: "last",role_id: 1)}
=======
RSpec.describe 'Creating a receipt', type: :feature do
  let(:admin) {Admin.create(email: "chrispasala@tamu.edu")}
  let(:user) {User.create(email: "chrispasala@tamu.edu", firstname: "first", lastname: "last",role_id: 3)}
>>>>>>> main

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

<<<<<<< HEAD
  scenario 'visiting account page ' do
    visit accounts_path
    expect(page).to have_content('Email:')
  end
end

RSpec.describe 'Member Pages Without Access', type: :feature do

  let(:admin) {Admin.create(email: "chrispasala@tamu.edu")}
  let(:user) {User.create(email: "chrispasala@tamu.edu", firstname: "first", lastname: "last",role_id: -2)}
  
  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
  end

  scenario 'visiting member page without sufficient permissions' do
    visit users_path
    expect(page).to have_content('You do not have access')
  end
end

=======
  scenario 'valid inputs' do
    visit new_receipt_path
    fill_in "receipt[value]", with: 123
    click_on 'Create Receipt'
    visit receipts_path
    expect(page).to have_content('Receipt ID')
  end
end

RSpec.describe 'Account Pages', type: :feature do
  let(:admin) {Admin.create(email: "chrispasala@tamu.edu")}
  let(:user) {User.create(email: "chrispasala@tamu.edu", firstname: "first", lastname: "last",role_id: 1)}

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario 'visiting account page ' do
    visit accounts_path
    expect(page).to have_content('Email:')
  end
end

RSpec.describe 'Member Pages Without Access', type: :feature do

  let(:admin) {Admin.create(email: "chrispasala@tamu.edu")}
  let(:user) {User.create(email: "chrispasala@tamu.edu", firstname: "first", lastname: "last",role_id: -1)}
  
  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario 'visiting member page without sufficient permissions' do
    visit users_path
    expect(page).to have_content('You do not have access')
  end
end


>>>>>>> main
RSpec.describe 'Member Pages With Access', type: :feature do

  let(:admin) {Admin.create(email: "chrispasala@tamu.edu")}
  let(:user) {User.create(email: "chrispasala@tamu.edu", firstname: "first", lastname: "last",role_id: 3)}

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
<<<<<<< HEAD
=======
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
>>>>>>> main
  end

  scenario 'visiting member page with sufficient permissions' do
    visit users_path
    expect(page).to have_content('Users')
  end

end