class AddColumnToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :status, :text, default: "active"
  end
end
