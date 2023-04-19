require 'rails_helper'

RSpec.describe 'Rider Creating a set', type: :feature do
  let(:admin) { Admin.find_or_create_by(email: "aramone@tamu.edu", first_name: "Axel", last_name: "Ramone", is_approved: true, aor_completed: true, boat_waiver_completed: true, dues_completed: true) }
  # let(:user) { User.find_or_create_by(email: "aramone@tamu.edu", firstname: "Axel", lastname: "Ramone", role_id: 1) }

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    allow_any_instance_of(Admin).to(receive(:has_role?).with("Driver").and_return(false))
    allow_any_instance_of(Admin).to(receive(:has_role?).with("Admin").and_return(false))
  end

  scenario "Rider viewing create button on sets page" do
    visit wakeboard_sets_path
    expect(page).not_to have_content('Create Set')
  end

  scenario "Rider creating set" do
    date = DateTime.current.tomorrow
    visit new_wakeboard_set_path
    expect(page).to have_content('Unauthorized')
  end
end

RSpec.describe 'Driver Creating a set', type: :feature do
  let(:admin) { Admin.find_or_create_by(email: "aramone@tamu.edu", first_name: "Axel", last_name: "Ramone", is_approved: true, aor_completed: true, boat_waiver_completed: true, dues_completed: true) }
  # let(:user) { User.find_or_create_by(email: "aramone@tamu.edu", firstname: "Axel", lastname: "Ramone", role_id: 1) }

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    allow_any_instance_of(Admin).to(receive(:has_role?).with("Driver").and_return(true))
    allow_any_instance_of(Admin).to(receive(:has_role?).with("Admin").and_return(false))
  end

  scenario "Driver creating a valid set" do
    date = DateTime.current.tomorrow
    visit new_wakeboard_set_path
    fill_in 'Scheduled date', with: date
    click_on 'Create Set'
    expect(page).not_to have_content('Error')
    visit wakeboard_sets_path
    expect(page).to have_content(admin.first_name)
    expect(find('table')).to have_content(date.strftime("%A"))
  end

  scenario "Driver creating set with date in the past" do
    date = DateTime.current.tomorrow
    visit new_wakeboard_set_path
    fill_in 'Scheduled date', with: date
    click_on 'Create Set'
    expect(page).not_to have_content('Error')
    visit wakeboard_sets_path
    expect(find('table')).to have_content(admin.first_name)
    expect(find('table')).to have_content(date.strftime("%A"))
  end

end

RSpec.describe 'Joining a set', type: :feature do
  let(:admin) { Admin.find_or_create_by(email: "aramone@tamu.edu", first_name: "Axel", last_name: "Ramone", is_approved: true, aor_completed: true, boat_waiver_completed: true, dues_completed: true) }
  
  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    allow_any_instance_of(Admin).to(receive(:has_role?).with("Driver").and_return(false))
    allow_any_instance_of(Admin).to(receive(:has_role?).with("Admin").and_return(false))
    @set = WakeboardSet.create!(
      dib_count: 0,
      chib_count: 0,
      driver_count: 1,
      scheduled_date: DateTime.current.tomorrow
    )
    SetDriver.create!(wakeboard_set_id: @set.id, admin_id:admin.id)
  end

  scenario 'Rider joining as a dib' do
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content(admin.last_name)
    click_on 'As Dib'
    visit wakeboard_set_path(@set.id)
    expect(page).to have_content(admin.first_name)
  end

  scenario 'Rider joining as a chib' do
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content(admin.last_name)
    click_on 'As Chib'
    visit wakeboard_set_path(@set.id)
    expect(page).to have_content(admin.first_name)
  end

  scenario 'Rider who is already joined as a dib trys to join as dib again' do
    visit wakeboard_set_path(@set.id)
    click_on 'As Dib'
    expect(page).to have_content(admin.first_name)
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content("As Dib")
  end

  scenario 'Rider who is already joined as a dib trys to join as chib' do
    visit wakeboard_set_path(@set.id)
    click_on 'As Dib'
    expect(page).to have_content(admin.first_name)
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content("As Chib")
  end

  scenario 'Rider who is already joined as a chib trys to join as chib again' do
    visit wakeboard_set_path(@set.id)
    click_on 'As Chib'
    expect(page).to have_content(admin.first_name)
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content("As Chib")
  end

  scenario 'Rider who is already joined as a chib trys to join as dib' do
    visit wakeboard_set_path(@set.id)
    click_on 'As Chib'
    expect(page).to have_content(admin.first_name)
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content("As Dib")
  end
end

RSpec.describe 'Leaving a set', type: :feature do
  let(:admin) { Admin.find_or_create_by(email: "aramone@tamu.edu", first_name: "Axel", last_name: "Ramone", is_approved: true, aor_completed: true, boat_waiver_completed: true, dues_completed: true) }
  
  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    allow_any_instance_of(Admin).to(receive(:has_role?).with("Driver").and_return(false))
    allow_any_instance_of(Admin).to(receive(:has_role?).with("Admin").and_return(false))
    @set = WakeboardSet.create!(
      dib_count: 0,
      chib_count: 0,
      driver_count: 1,
      scheduled_date: DateTime.current.tomorrow
    )
    SetDriver.create!(wakeboard_set_id: @set.id, admin_id:admin.id)
  end

  scenario 'Dib rider leaving' do
    visit wakeboard_set_path(@set.id)
    click_on 'As Dib'
    expect(page).to have_content(admin.last_name)
    visit wakeboard_set_path(@set.id)
    click_on 'Leave Set'
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content(admin.last_name)
  end

  scenario 'Chib rider leaving' do
    visit wakeboard_set_path(@set.id)
    click_on 'As Chib'
    expect(page).to have_content(admin.last_name)
    visit wakeboard_set_path(@set.id)
    click_on 'Leave Set'
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content(admin.last_name)
  end

  scenario 'Rider who isn\'t on set leaving' do
    visit wakeboard_set_path(@set.id)
    expect(page).not_to have_content('Leave Set')
  end
end