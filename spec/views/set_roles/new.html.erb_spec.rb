require 'rails_helper'

RSpec.describe('set_roles/new') do
     before do
          assign(:set_role, SetRole.new(
                                 role_id: nil,
                                 user_id: nil
                            )
          )
     end

     it 'renders new set_role form' do
          render

          assert_select 'form[action=?][method=?]', set_roles_path, 'post' do
               assert_select 'input[name=?]', 'set_role[role_id_id]'

               assert_select 'input[name=?]', 'set_role[user_id_id]'
          end
     end
end
