class ChangeUserStatusToString < ActiveRecord::Migration
  def change
    change_column :users, :owner_status,  :string
  end
end
