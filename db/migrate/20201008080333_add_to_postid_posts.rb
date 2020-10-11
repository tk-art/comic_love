class AddToPostidPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :post_id, :integer, after: :visited_id
    add_index :notifications, :post_id
  end
end
