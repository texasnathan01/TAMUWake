# location: spec/feature/receipt_integration_spec.rb
require 'rails_helper'

RSpec.describe 'Go to receipts page as treasurer', type: :feature do
  let(:admin) {Admin.create(email: "chrispasala@tamu.edu", first_name: "first", last_name: "last",role_id: 3)}

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
  end

  scenario 'valid inputs' do
    visit receipts_path
    expect(page).to have_content('Treasurer Page')
  end
end
  
RSpec.describe 'Go to receipts page as driver', type: :feature do
  let(:admin) {Admin.create(email: "chrispasala@tamu.edu", first_name: "Nathan", last_name: "Wilke",role_id: 1)}

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
  end

  scenario 'valid inputs' do
    visit receipts_path
    expect(page).to have_content('Receipts for Nathan Wilke')
  end
end
  
RSpec.describe 'Go to receipts page as non driver and non treasurer', type: :feature do
  let(:admin) {Admin.create(email: "chrispasala@tamu.edu", first_name: "Nathan", last_name: "Wilke",role_id: -1)}

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
  end

  scenario 'valid inputs' do
    visit receipts_path
    expect(page).to have_content('please contact your administrator')
  end
end

RSpec.describe 'Driver creating a new receipt', type: :feature do
  let(:admin) {Admin.create(email: "chrispasala@tamu.edu", first_name: "Nathan", last_name: "Wilke",role_id: 1)}

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
  end

  scenario 'valid inputs' do
    visit new_receipt_path
    fill_in "receipt[value]", with: 123
    fill_in "receipt[date_made]", with: '1999-01-08'
    fill_in "receipt[image_link]", with: 'https://www.snopes.com/tachyon/2021/08/239918331_10228097135359041_3825446756894757753_n.jpg'
    click_on 'Create Receipt'
    visit receipts_path
    expect(page).to have_content('Receipt ID')
  end

  scenario 'missing inputs' do
    visit new_receipt_path
    click_on 'Create Receipt'
    expect(page).to have_content('prohibited this receipt')
  end
end



