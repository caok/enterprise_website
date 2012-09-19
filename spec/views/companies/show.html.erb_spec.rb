require 'spec_helper'

describe "companies/show" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :name => "Name",
      :about => "MyText",
      :culture => "MyText",
      :contract => "Contract",
      :mobile => "Mobile",
      :tel => "Tel",
      :fax => "Fax",
      :qq => "Qq",
      :links => "Links",
      :address => "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Contract/)
    rendered.should match(/Mobile/)
    rendered.should match(/Tel/)
    rendered.should match(/Fax/)
    rendered.should match(/Qq/)
    rendered.should match(/Links/)
    rendered.should match(/Address/)
  end
end
