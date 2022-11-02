require 'rails_helper'

RSpec.describe Patient, type: :model do
  subject(:patient) { Patient.new }

  context "validações" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
    it { is_expected.to validate_presence_of(:birthdate) }
    it { is_expected.to validate_presence_of(:address_street) }
    it { is_expected.to validate_presence_of(:address_neighborhood) }
    it { is_expected.to validate_presence_of(:address_city) }
    it { is_expected.to validate_presence_of(:address_state) }
  end
end
