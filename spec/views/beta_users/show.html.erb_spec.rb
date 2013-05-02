require 'spec_helper'

describe "beta_users/show" do
  before(:each) do
    @beta_user = assign(:beta_user, stub_model(BetaUser,
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => "Email",
      :beta_intrest => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
    rendered.should match(/false/)
  end
end
