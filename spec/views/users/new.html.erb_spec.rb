require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      email: "MyString",
      firstname: "MyString",
      lastname: "MyString",
      password: "MyText",
      roleID: 1
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[firstname]"

      assert_select "input[name=?]", "user[lastname]"

      assert_select "textarea[name=?]", "user[password]"

      assert_select "input[name=?]", "user[roleID]"
    end
  end
end
