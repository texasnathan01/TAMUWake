# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe('Using Account Page and Tools', type: :feature) do
     let(:admin) { Admin.create!(email: 'chrispasala@tamu.edu', first_name: 'first', last_name: 'last', is_approved: true, role_id: -2) }

     before do
          allow_any_instance_of(ApplicationController).to(receive(:authenticate_admin!).and_return(true))
          allow_any_instance_of(ApplicationController).to(receive(:current_admin).and_return(admin))
     end

     it 'visiting account page' do
          visit accounts_path
          expect(page).to(have_content('chrispasala@tamu.edu'))
     end

     it 'visiting account page and editing user info' do
          visit edit_admin_path(admin.id)
          fill_in 'admin[first_name]', with: 'new_name'
          click_on 'Update Account Info'
          expect(page).to(have_content('new_name'))
     end

     # rainy day case
     it 'visiting any page without being approved' do
          admin.is_approved = false
          visit edit_admin_path(admin.id)
          expect(page).to(have_content('not yet approved'))
     end

     it 'visiting account page without being approved' do
          admin.is_approved = false
          visit accounts_path
          expect(page).not_to(have_content('not yet approved'))
     end
end
