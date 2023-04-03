require 'rails_helper'

RSpec.describe "roles/new", type: :view do
  before(:each) do
    assign(:role, Role.new(
      role_id: 1,
      role_name: "MyString"
    ))
  end

  it "renders new role form" do
    render

    assert_select "form[action=?][method=?]", roles_path, "post" do

      assert_select "input[name=?]", "role[role_id]"

      assert_select "input[name=?]", "role[role_name]"
    end
  end
end
