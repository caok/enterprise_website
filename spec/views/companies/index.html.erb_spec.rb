require 'spec_helper'

describe "companies/index" do
  before(:each) do
    assign(:companies, [
      stub_model(Company,
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
      ),
      stub_model(Company,
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
      )
    ])
  end

  it "renders a list of companies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Contract".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile".to_s, :count => 2
    assert_select "tr>td", :text => "Tel".to_s, :count => 2
    assert_select "tr>td", :text => "Fax".to_s, :count => 2
    assert_select "tr>td", :text => "Qq".to_s, :count => 2
    assert_select "tr>td", :text => "Links".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
  end
end
