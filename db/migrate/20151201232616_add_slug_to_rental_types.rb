class AddSlugToRentalTypes < ActiveRecord::Migration
  def change
    add_column :rental_types, :slug, :string
  end
end
