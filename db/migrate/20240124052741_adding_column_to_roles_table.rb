class AddingColumnToRolesTable < ActiveRecord::Migration[7.1]
  def change
  	add_column :roles, :user_id, :string
  end
end
