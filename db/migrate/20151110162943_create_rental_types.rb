class CreateRentalTypes < ActiveRecord::Migration
  def change
    create_table :rental_types do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
