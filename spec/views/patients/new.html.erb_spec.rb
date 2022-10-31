require 'rails_helper'

RSpec.describe "patients/new", type: :view do
  before(:each) do
    assign(:patient, Patient.new(
      name: "MyString",
      cpf: "MyString",
      address_street: "MyString",
      address_neighborhood: "MyString",
      address_city: "MyString",
      address_state: "MyString"
    ))
  end

  it "renders new patient form" do
    render

    assert_select "form[action=?][method=?]", patients_path, "post" do

      assert_select "input[name=?]", "patient[name]"

      assert_select "input[name=?]", "patient[cpf]"

      assert_select "input[name=?]", "patient[address_street]"

      assert_select "input[name=?]", "patient[address_neighborhood]"

      assert_select "input[name=?]", "patient[address_city]"

      assert_select "input[name=?]", "patient[address_state]"
    end
  end
end
