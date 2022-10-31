class PatientsController < ApplicationController
  # GET /patients or /patients.json
  def index
  end

  # GET /patients/1 or /patients/1.json
  def show
  end

  # GET /patients/new
  def new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients or /patients.json
  def create
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
  end

  private

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :cpf, :birthdate, :address_street, :address_neighborhood, :address_city, :address_state)
    end
end
