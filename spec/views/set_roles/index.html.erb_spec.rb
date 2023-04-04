require 'rails_helper'

RSpec.describe "set_roles/index", type: :view do
  before(:each) do
    assign(:set_roles, [
      SetRole.create!(
        role_id: nil,
        user_id: nil
      ),
      SetRole.create!(
        role_id: nil,
        user_id: nil
      )
    ])
  end

  it "renders a list of set_roles" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
