require 'spec_helper'

describe "beta_users/index" do
  before(:each) do
    assign(:beta_users, [
      stub_model(BetaUser,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :beta_intrest => false
      ),
      stub_model(BetaUser,
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :beta_intrest => false
      )
    ])
  end

  it "renders a list of beta_users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
