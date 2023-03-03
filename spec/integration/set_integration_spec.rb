require 'rails_helper'

RSpec.describe 'Creating a set', type: :feature do
  before :each do
    @admin = Admin.where(role_id: 1).limit(1)[0]
    sign_in @admin
  end

  scenario "Driver creating a valid set" do
    date = DateTime.current.tomorrow
    visit new_wakeboard_set_path
    fill_in 'Scheduled Date', with: date
    click_on 'Create Set'
    expect(page).not_to have_content('Error')
    visit wakeboard_sets_path
    expect(find('table')).to have_content(@admin.fullname.split()[0])
    expect(find('table')).to have_content(date)
  end

  scenario "Driver creating set with date in the past" do
    date = DateTime.current.tomorrow
    visit new_wakeboard_set_path
    fill_in 'Scheduled Date', with: date
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
    expect(page).not_to have_content('Create a Set')
  end

  scenario "Rider creating set" do
    sign_out @admin
    visit new_wakeboard_set_path
    fill_in 'Scheduled Date', with: date
    click_on 'Create Set'
    expect(page).to have_content('Error')
  end
end

RSpec.describe 'Joining a set', type: :feature do
  before :each do
    @admin = Admin.where(role_id: 1).limit(1)[0]
    sign_in @admin
  end

  scenario 'Rider joining as a dib' do
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).not_to have_content(@admin.full_name)
    click_on 'Join as Dib'
    visit wakeboard_set_path(1)
    expect(find('#dib-table')).to have_content(@admin.full_name)
  end

  scenario 'Rider joining as a chib' do
    visit wakeboard_set_path(1)
    expect(find('#chib-table')).not_to have_content(@admin.full_name)
    click_on 'Join as Chib'
    visit wakeboard_set_path(1)
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