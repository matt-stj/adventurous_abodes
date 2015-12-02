class AddUserRefToRentals < ActiveRecord::Migration
  def change
    add_reference :rentals, :user, index: true, foreign_key: true
  end
end
