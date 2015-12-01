class AddActivityIdToRentals < ActiveRecord::Migration
  def change
    add_reference :rentals, :activity, index: true, foreign_key: true
  end
end
