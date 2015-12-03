class RenameOrderedTripstoReservations < ActiveRecord::Migration
  def up
    rename_table :ordered_trips, :reservations
  end
  def down
    rename_table :reservations, :ordered_trips
  end
end
