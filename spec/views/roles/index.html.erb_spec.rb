require 'rails_helper'

RSpec.describe('roles/index') do
     before do
          assign(:roles, [
               Role.create!(
                    role_id: 2,
                    role_name: 'Role Name'
               ),
               Role.create!(
                    role_id: 2,
                    role_name: 'Role Name'
               )
          ]
          )
     end

     it 'renders a list of roles' do
          render
          cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
          assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
          assert_select cell_selector, text: Regexp.new('Role Name'.to_s), count: 2
     end
end
