class AddIsAdminColumnDefaultToUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :is_admin, false
  end
end
