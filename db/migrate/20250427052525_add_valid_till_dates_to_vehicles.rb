class AddValidTillDatesToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_column :vehicles, :green_card_valid_till, :date
    add_column :vehicles, :trip_card_valid_till, :date
  end
end
