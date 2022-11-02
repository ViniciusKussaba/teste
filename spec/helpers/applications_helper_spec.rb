require 'rails_helper'

RSpec.describe PatientsHelper, type: :helper do
  describe "#format_date" do
    subject(:format_date) { helper.format_date(date) }

    context "quando uma data é passada" do
      let(:date) { Date.parse("2022-11-05") }

      it { expect(format_date).to eq("05/11/2022") }
    end

    context "quando uma data NÃO é passada" do
      let(:date) { nil }

      it { expect(format_date).to eq("Não informado") }
    end
  end
end
