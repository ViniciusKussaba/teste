class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]

  # GET /patients or /patients.json
  def index
    @patients = Patient.all
  end

  # GET /patients/1 or /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients or /patients.json
  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to patient_url(@patient), notice: "Paciente foi criado corretamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    if @patient.update(patient_params)
      redirect_to patient_url(@patient), notice: "Paciente foi atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @patient.destroy

    redirect_to patients_url, notice: "Paciente foi excluído com sucesso."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(
        %i[
          name
          cpf
          birthdate
          address_street
          address_neighborhood
          address_city
          address_state
        ]
      )
    end
end
