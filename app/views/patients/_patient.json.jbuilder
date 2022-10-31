json.extract! patient, :id, :name, :cpf, :birthdate, :address_street, :address_neighborhood, :address_city, :address_state, :created_at, :updated_at
json.url patient_url(patient, format: :json)
