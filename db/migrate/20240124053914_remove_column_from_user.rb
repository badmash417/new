class RemoveColumnFromUser < ActiveRecord::Migration[7.1]
  def change
  	remove_column :users, :role_id, :string
  end
end
