class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :cpf
      t.date :birthdate
      t.string :address_street
      t.string :address_neighborhood
      t.string :address_city
      t.string :address_state

      t.timestamps
    end
  end
end
