require 'rails_helper'

RSpec.describe "patients/index", type: :view do
  before(:each) do
    assign(:patients, [
      Patient.create!(
        name: "Name",
        cpf: "Cpf",
        address_street: "Address Street",
        birthdate: Date.today,
        address_neighborhood: "Address Neighborhood",
        address_city: "Address City",
        address_state: "Address State"
      ),
      Patient.create!(
        name: "Name",
        cpf: "Cpf 2",
        birthdate: Date.today,
        address_street: "Address Street",
        address_neighborhood: "Address Neighborhood",
        address_city: "Address City",
        address_state: "Address State"
      )
    ])
  end

  it "renders a list of patients" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'tr>td' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cpf".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address Street".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address Neighborhood".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address City".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address State".to_s), count: 2
  end
end
