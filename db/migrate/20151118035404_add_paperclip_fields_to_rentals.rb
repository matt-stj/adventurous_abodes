class AddPaperclipFieldsToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :image_file_name,    :string
    add_column :rentals, :image_content_type, :string
    add_column :rentals, :image_file_size,    :integer
    add_column :rentals, :image_updated_at,   :datetime
  end
end
