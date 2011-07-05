require 'spec_helper'

describe "registrations/index.html.haml" do
  before(:each) do
    assign(:registrations, [
      stub_model(Registration,
        :name => "Name",
        :email => "Email",
        :password => "Password",
        :password_confirmation => "Password Confirmation"
      ),
      stub_model(Registration,
        :name => "Name",
        :email => "Email",
        :password => "Password",
        :password_confirmation => "Password Confirmation"
      )
    ])
  end

  it "renders a list of registrations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Password Confirmation".to_s, :count => 2
  end
end
