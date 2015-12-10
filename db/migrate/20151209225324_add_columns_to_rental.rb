class AddColumnsToRental < ActiveRecord::Migration
  def change
    add_column :rentals, :english_butler, :string
    add_column :rentals, :onsite_masseuse, :string
    add_column :rentals, :private_movie_theater, :string
    add_column :rentals, :elite_golf_course, :string
    add_column :rentals, :results_oriented_gym, :string
    add_column :rentals, :luxury_private_jet, :string
    add_column :rentals, :olympic_pool, :string
    add_column :rentals, :in_house_pet_psychic, :string
  end
end
