class AddIndexesToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_index :vehicles, :vehicle_number
    add_index :vehicles, :check_date
    add_index :vehicles, :owner
    add_index :vehicles, :checkpost
    add_index :vehicles, :char_dham_registration_number
  end
end
