# require 'rails_helper'

# RSpec.describe "roles/edit", type: :view do
#   let(:role) {
#     Role.create!(
#       role_id: 1,
#       role_name: "MyString"
#     )
#   }

#   before(:each) do
#     assign(:role, role)
#   end

#   it "renders the edit role form" do
#     render

#     assert_select "form[action=?][method=?]", role_path(role), "post" do

#       assert_select "input[name=?]", "role[role_id]"

#       assert_select "input[name=?]", "role[role_name]"
#     end
#   end
# end
