# require 'rails_helper'

# RSpec.describe "set_roles/edit", type: :view do
#   let(:set_role) {
#     SetRole.create!(
#       role_id: nil,
#       user_id: nil
#     )
#   }

#   before(:each) do
#     assign(:set_role, set_role)
#   end

#   it "renders the edit set_role form" do
#     render

#     assert_select "form[action=?][method=?]", set_role_path(set_role), "post" do

#       assert_select "input[name=?]", "set_role[role_id_id]"

#       assert_select "input[name=?]", "set_role[user_id_id]"
#     end
#   end
# end
