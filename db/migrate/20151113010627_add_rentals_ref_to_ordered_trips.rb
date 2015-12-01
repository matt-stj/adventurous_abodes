class AddRentalsRefToOrderedTrips < ActiveRecord::Migration
  def change
    add_reference :ordered_trips, :rental, index: true, foreign_key: true
  end
end
