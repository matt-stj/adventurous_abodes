class ChangeActiveOwnerToUserStatus < ActiveRecord::Migration
  def change
    rename_column :users, :active_owner?, :owner_status
  end
end
