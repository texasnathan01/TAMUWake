require 'rails_helper'

RSpec.describe 'Creating a set', type: :feature do
  let(:admin) { Admin.find_or_create_by(email: "aramone@tamu.edu") }
  let(:user) { User.find_or_create_by(email: "aramone@tamu.edu", firstname: "Axel", lastname: "Ramone", role_id: 1) }

  before :each do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_admin!).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_admin).and_return(admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  scenario "Driver creating a valid set" do
    date = DateTime.current.tomorrow
    visit new_wakeboard_set_path
    fill_in 'Scheduled date', with: date
    click_on 'Create Set'
    expect(page).not_to have_content('Error')
    visit wakeboard_sets_path
    expect(page).to have_content(@admin.fullname.split()[0])
    expect(find('table')).to have_content(date)
  end

  scenario "Driver creating set with date in the past" do
    date = DateTime.current.tomorrow
    visit new_wakeboard_set_path
    fill_in 'Scheduled date', with: date
    click_on 'Create Set'
    expect(page).not_to have_content('Error')
    visit wakeboard_sets_path
    expect(find('table')).to have_content(@admin.fullname.split()[0])
    expect(find('table')).to have_content(date)
  end

  scenario "Rider viewing create button on sets page" do
    sign_out @admin
    # TODO sign in as a default user
    visit wakeboard_sets_path
    expect(page).to have_content('Sets this Week')
  end

  scenario "Rider creating set" do
    date = DateTime.current.tomorrow
    sign_out @admin
    visit new_wakeboard_set_path
    fill_in 'Scheduled date', with: date
    click_on 'Create Set'
    expect(page).to have_content('Error')
  end
end

RSpec.describe 'Joining a set', type: :feature do
  before :each do
    @set = WakeboardSet.find_or_create_by(
      dib_count: 0,
      chib_count: 0,
      driver_count: 1,
      scheduled_date: DateTime.current.tomorrow
    )
  end

  scenario 'Rider joining as a dib' do
    visit wakeboard_set_path(@set.id)
    expect(find('#chib-table')).not_to have_content(@admin.full_name)
    click_on 'Join as Dib'
    visit wakeboard_set_path(@set.id)
    expect(find('#chib-table')).to have_content(@admin.full_name)
  end

  scenario 'Rider joining as a chib' do
    visit wakeboard_set_path(@set.id)
    expect(find('#chib-table')).not_to have_content(@admin.full_name)
    click_on 'Join as Chib'
    visit wakeboard_set_path(@set.id)
    expect(find('#chib-table')).to have_content(@admin.full_name)
  end

  scenario 'Rider who is already joined as a dib trys to join as dib again' do
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).to have_content(@admin.full_name)
    click_on 'Join as Dib'
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).to have_content(@admin.full_name)
  end

  scenario 'Rider who is already joined as a dib trys to join as chib' do
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).to have_content(@admin.full_name)
    click_on 'Join as Chib'
    visit wakeboard_set_path(1)
    expect(find('#chib-table')).not_to have_content(@admin.full_name)
  end

  scenario 'Rider who is already joined as a chib trys to join as chib again' do
    visit wakeboard_set_path(1)
    expect(find('#chib-table')).to have_content(@admin.full_name)
    click_on 'Join as Dib'
    visit wakeboard_set_path(1)
    expect(find('#chib-table')).to have_content(@admin.full_name)
  end

  scenario 'Rider who is already joined as a chib trys to join as dib' do
    visit wakeboard_set_path(1)
    expect(find('#chib-table')).to have_content(@admin.full_name)
    click_on 'Join as Chib'
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).not_to have_content(@admin.full_name)
  end
end

RSpec.describe 'Leaving a set', type: :feature do
  before :each do
    @admin = Admin.where(role_id: 1).limit(1)[0]
    sign_in @admin
  end

  scenario 'Dib rider leaving' do
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).to have_content(@admin.full_name)
    click_on 'Leave Set'
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).not_to have_content(@admin.full_name)
    expect(find('#chib-table')).not_to have_content(@admin.full_name)
  end

  scenario 'Chib rider leaving' do
    visit wakeboard_set_path(1)
    expect(find('#chib-table')).to have_content(@admin.full_name)
    click_on 'Leave Set'
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).not_to have_content(@admin.full_name)
    expect(find('#chib-table')).not_to have_content(@admin.full_name)
  end

  scenario 'Dib and Chib rider leaving' do
    visit wakeboard_set_path(1)
    expect(find('#chib-table')).to have_content(@admin.full_name)
    expect(find('#dib-table')).to have_content(@admin.full_name)
    click_on 'Leave Set'
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).not_to have_content(@admin.full_name)
    expect(find('#chib-table')).not_to have_content(@admin.full_name)
  end

  scenario 'Rider who isn\'t on set leaving' do
    visit wakeboard_set_path(1)
    expect(page).not_to have_content(@admin.full_name)
    expect(page).not_to have_content('Leave Set')
  end
end