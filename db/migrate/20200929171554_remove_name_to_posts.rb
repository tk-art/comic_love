class RemoveNameToPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :name
  end
end
