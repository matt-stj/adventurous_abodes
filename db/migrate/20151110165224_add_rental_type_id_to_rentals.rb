class AddRentalTypeIdToRentals < ActiveRecord::Migration
  def change
    add_reference :rentals, :rental_type, index: true, foreign_key: true
  end
end
