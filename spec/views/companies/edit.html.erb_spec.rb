require 'spec_helper'

describe "companies/edit" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :name => "MyString",
      :about => "MyText",
      :culture => "MyText",
      :contract => "MyString",
      :mobile => "MyString",
      :tel => "MyString",
      :fax => "MyString",
      :qq => "MyString",
      :links => "MyString",
      :address => "MyString"
    ))
  end

  it "renders the edit company form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => companies_path(@company), :method => "post" do
      assert_select "input#company_name", :name => "company[name]"
      assert_select "textarea#company_about", :name => "company[about]"
      assert_select "textarea#company_culture", :name => "company[culture]"
      assert_select "input#company_contract", :name => "company[contract]"
      assert_select "input#company_mobile", :name => "company[mobile]"
      assert_select "input#company_tel", :name => "company[tel]"
      assert_select "input#company_fax", :name => "company[fax]"
      assert_select "input#company_qq", :name => "company[qq]"
      assert_select "input#company_links", :name => "company[links]"
      assert_select "input#company_address", :name => "company[address]"
    end
  end
end
