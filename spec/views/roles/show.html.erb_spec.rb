require 'rails_helper'

RSpec.describe('roles/show') do
     before do
          assign(:role, Role.create!(
                             role_id: 2,
                             role_name: 'Role Name'
                        )
          )
     end

     it 'renders attributes in <p>' do
          render
          expect(rendered).to(match(/2/))
          expect(rendered).to(match(/Role Name/))
     end
end
