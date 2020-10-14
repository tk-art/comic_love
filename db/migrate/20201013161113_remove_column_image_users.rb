class RemoveColumnImageUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :image
  end
end
