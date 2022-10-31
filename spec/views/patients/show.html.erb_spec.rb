require 'rails_helper'

RSpec.describe "patients/show", type: :view do
  before(:each) do
    assign(:patient, Patient.create!(
      name: "Name",
      cpf: "Cpf",
      address_street: "Address Street",
      address_neighborhood: "Address Neighborhood",
      address_city: "Address City",
      address_state: "Address State"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Cpf/)
    expect(rendered).to match(/Address Street/)
    expect(rendered).to match(/Address Neighborhood/)
    expect(rendered).to match(/Address City/)
    expect(rendered).to match(/Address State/)
  end
end
