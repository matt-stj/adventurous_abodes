class AddDefaultValueForUserImage < ActiveRecord::Migration
  def change
    change_column :users, :image_url, :string, :default => "https://robohash.org/default.png"
  end
end
