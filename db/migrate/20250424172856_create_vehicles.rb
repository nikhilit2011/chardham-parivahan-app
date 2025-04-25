# Force re-deploy to Render

class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_number
      t.string :checkpost
      t.string :owner
      t.string :char_dham_registration_number
      t.string :green_card_status
      t.string :trip_card_status
      t.date :check_date
      t.integer :number_of_pilgrims
      t.string :dham_destinations
      t.date :return_date
      t.boolean :registered_in_uttarakhand
      t.text :remarks

      t.timestamps
      add_index :vehicles, [:vehicle_number, :check_date], unique: true
    end
  end
end
