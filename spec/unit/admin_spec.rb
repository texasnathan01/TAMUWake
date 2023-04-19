# location: spec/unit/admin_spec.rb
require 'rails_helper'

RSpec.describe "a user" do

  it "has their information using a helper" do
    user = 
    expect(subject).to be_valid
  end

  it 'is valid with when attributes changed' do
    subject.first_name = "Axel"
    expect(subject).to be_valid
  end

end
