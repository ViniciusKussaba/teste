require 'rails_helper'

RSpec.describe "patients/edit", type: :view do
  let(:patient) {
    Patient.create!(
      name: "MyString",
      cpf: "MyString",
      address_street: "MyString",
      address_neighborhood: "MyString",
      address_city: "MyString",
      address_state: "MyString"
    )
  }

  before(:each) do
    assign(:patient, patient)
  end

  it "renders the edit patient form" do
    render

    assert_select "form[action=?][method=?]", patient_path(patient), "post" do

      assert_select "input[name=?]", "patient[name]"

      assert_select "input[name=?]", "patient[cpf]"

      assert_select "input[name=?]", "patient[address_street]"

      assert_select "input[name=?]", "patient[address_neighborhood]"

      assert_select "input[name=?]", "patient[address_city]"

      assert_select "input[name=?]", "patient[address_state]"
    end
  end
end
