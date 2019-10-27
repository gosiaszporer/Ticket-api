class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :name
      t.float :price
      t.integer :quantity
      t.references :event

      t.timestamps
    end
  end
end
