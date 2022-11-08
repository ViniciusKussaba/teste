require 'rails_helper'

RSpec.describe "/patients", type: :request do
  let(:valid_attributes) {
    {
      name: 'Felipe',
      cpf: '123.456.789-98',
      birthdate: '12/12/1980',
      address_street: 'Rua Um, 321',
      address_neighborhood: 'Bairro Nobre',
      address_city: 'Poços de Caldas',
      address_state: 'MG'
    }
  }

  let(:other_valid_attributes) {
    {
      name: 'Wallison',
      cpf: '987.654.321-12',
      birthdate: '05/12/1992',
      address_street: 'Rua dos Pardais, 775',
      address_neighborhood: 'Bairro Rural',
      address_city: 'Poços de Caldas',
      address_state: 'MG'
    }
  }

  let(:invalid_attributes) {
    {
      name: 'Felipe',
      cpf: nil,
      birthdate: '12/12/1980',
      address_street: 'Rua Um, 321',
      address_neighborhood: 'Bairro Nobre',
      address_city: 'Poços de Caldas',
      address_state: 'MG'
    }
  }

  describe "GET /index" do
    subject(:get_index) { get patients_path }

    before do
      Patient.create! valid_attributes
      Patient.create! other_valid_attributes
    end

    it "renderiza a index.html" do
      is_expected.to render_template :index
    end

    it "retorna o HTTP Status 200 (OK)" do
      get_index

      expect(response).to have_http_status :ok
    end

    it "pega a lista com todos os pacientes" do
      get_index

      expected_patient_list = Patient.all
      returned_patient_list = assigns(:patients) # Recupera o @patients da index na controller

      expect(returned_patient_list).to eq(expected_patient_list)
    end
  end

  describe "GET /show" do
    subject(:get_show) { get patient_path(id: patient) }

    context "quando existe o paciente" do
      let(:patient) { Patient.create! valid_attributes }

      it "renderiza a show.html" do
        is_expected.to render_template :show
      end

      it "retorna o HTTP Status 200 (OK)" do
        get_show

        expect(response).to have_http_status :ok
      end

      it "retorna o paciente em específico" do
        get_show

        returned_patient = assigns(:patient) # Recupera o @patient da show na controller

        expect(returned_patient).to eq(patient)
      end
    end

    context "quando NÃO existe o paciente" do
      let(:patient) { 123 }

      it "redireciona para a index" do
        is_expected.to redirect_to patients_path
      end

      it "retorna o HTTP Status 302 (Redirect)" do
        get_show

        expect(response).to have_http_status :redirect
      end
    end
  end

  describe "GET /new" do
    subject(:get_new) { get new_patient_path }

    it "renderiza a new.html" do
      is_expected.to render_template :new
    end

    it "retorna o HTTP Status 200 (OK)" do
      get_new

      expect(response).to have_http_status :ok
    end

    it "pega um paciente sem dados preenchidos" do
      get_new

      returned_patient = assigns(:patient) # Recupera o @patient da new na controller

      expect(returned_patient).to be_a_new(Patient)
    end
  end

  describe "GET /edit" do
    subject(:get_edit) { get edit_patient_path(id: patient) }

    context "quando existe o paciente" do
      let(:patient) { Patient.create! valid_attributes }

      it "renderiza a edit.html" do
        is_expected.to render_template :edit
      end

      it "retorna o HTTP Status 200 (OK)" do
        get_edit

        expect(response).to have_http_status :ok
      end

      it "retorna o paciente em específico" do
        get_edit

        returned_patient = assigns(:patient) # Recupera o @patient da edit na controller

        expect(returned_patient).to eq(patient)
      end
    end

    context "quando NÃO existe o paciente" do
      let(:patient) { 123 }

      it "redireciona para a index" do
        is_expected.to redirect_to patients_path
      end

      it "retorna o HTTP Status 302 (Redirect)" do
        get_edit

        expect(response).to have_http_status :redirect
      end
    end
  end

  describe "POST /create" do
    subject(:post_create) { post patients_url, params: { patient: params } }

    context "com parâmetros válidos" do
      let(:params) { valid_attributes }

      it "cria um novo paciente" do
        expect { post_create }.to change { Patient.count }.by(1)
      end

      it "redireciona para a index" do
        is_expected.to redirect_to patient_path(id: Patient.last)
      end

      it "retorna o HTTP Status 302 (Redirect)" do
        post_create

        expect(response).to have_http_status :redirect
      end
    end

    context "com parâmetros INválidos" do
      let(:params) { invalid_attributes }

      it "NÃO cria um paciente" do
        expect { post_create }.to avoid_changing { Patient.count }
      end

      it "renderiza a new.html" do
        is_expected.to render_template :new
      end

      it "retorna os erros que ocorreram quando tentou criar o paciente" do
        post_create

        returned_patient = assigns(:patient) # Recupera o @patient da create na controller

        expect(returned_patient.errors).to be_present
      end

      it "retorna o HTTP Status 422 (Unprocessable entity)" do
        post_create

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe "PATCH /update" do
    subject(:patch_update) { patch patient_path(patient), params: { patient: params } }

    context "quando existe o paciente" do
      let(:patient) { Patient.create! valid_attributes }

      context "com parâmetros válidos" do
        let(:params) do
          {
            address_street: 'Rua das Rosas, 555'
          }
        end

        it "atualiza o endereço do paciente" do
          expect { patch_update }.to change { patient.reload.address_street }.from('Rua Um, 321').to('Rua das Rosas, 555')
        end

        it "redireciona para a show" do
          is_expected.to redirect_to patient_path(id: patient)
        end

        it "retorna o HTTP Status 302 (Redirect)" do
          patch_update

          expect(response).to have_http_status :redirect
        end
      end

      context "com parâmetros INválidos" do
        let(:params) { invalid_attributes }

        it "NÃO atualiza o paciente" do
          expect { patch_update }.to avoid_changing { patient.reload }
        end

        it "renderiza a edit.html" do
          is_expected.to render_template :edit
        end

        it "retorna os erros que ocorreram quando tentou atualizar o paciente" do
          patch_update

          returned_patient = assigns(:patient) # Recupera o @patient da update na controller

          expect(returned_patient.errors).to be_present
        end

        it "retorna o HTTP Status 422 (Unprocessable entity)" do
          patch_update

          expect(response).to have_http_status :unprocessable_entity
        end
      end
    end

    context "quando NÃO existe o paciente" do
      let(:patient) { 123 }
      let(:params) { {} }

      it "redireciona para a index" do
        is_expected.to redirect_to patients_path
      end

      it "retorna o HTTP Status 302 (Redirect)" do
        patch_update

        expect(response).to have_http_status :redirect
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:delete_destroy) { delete patient_path(id: patient) }

    context "quando existe o paciente" do
      let!(:patient) { Patient.create! valid_attributes }

      it "deleta o paciente" do
        expect { delete_destroy }.to change { Patient.count }.by(-1)
      end

      it "redireciona para a index" do
        is_expected.to redirect_to patients_path
      end

      it "retorna o HTTP Status 302 (Redirect)" do
        delete_destroy

        expect(response).to have_http_status :redirect
      end
    end

    context "quando NÃO existe o paciente" do
      let(:patient) { 123 }

      it "NÃO deleta nenhum paciente" do
        expect { delete_destroy }.to avoid_changing { Patient.count }
      end

      it "redireciona para a index" do
        is_expected.to redirect_to patients_path
      end

      it "retorna o HTTP Status 302 (Redirect)" do
        delete_destroy

        expect(response).to have_http_status :redirect
      end
    end
  end
end
