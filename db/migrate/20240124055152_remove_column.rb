class RemoveColumn < ActiveRecord::Migration[7.1]
  def change
  	remove_column :roles, :user_id, :string
  end
end
