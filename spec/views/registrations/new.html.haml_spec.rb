require 'spec_helper'

describe "registrations/new.html.haml" do
  before(:each) do
    assign(:registration, stub_model(Registration,
      :name => "MyString",
      :email => "MyString",
      :password => "MyString",
      :password_confirmation => "MyString"
    ).as_new_record)
  end

  it "renders new registration form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => registrations_path, :method => "post" do
      assert_select "input#registration_name", :name => "registration[name]"
      assert_select "input#registration_email", :name => "registration[email]"
      assert_select "input#registration_password", :name => "registration[password]"
      assert_select "input#registration_password_confirmation", :name => "registration[password_confirmation]"
    end
  end
end
