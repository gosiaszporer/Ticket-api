class CreateReservationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :reservation_details do |t|
      t.integer :quantity
      t.references :reservation
      t.references :ticket

      t.timestamps
    end
  end
end
