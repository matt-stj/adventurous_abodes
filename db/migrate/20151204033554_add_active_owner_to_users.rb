class AddActiveOwnerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_owner?, :boolean
  end
end
