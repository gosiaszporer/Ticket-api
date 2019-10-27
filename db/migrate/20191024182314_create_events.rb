class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.boolean :even, null: false, default: false
      t.boolean :all_together, null: false, default: false
      t.boolean :avoid_one, null: false, default: false

      t.timestamps
    end
  end
end
