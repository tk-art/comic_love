class AddApiValueToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :isbn, :bigint, after: :content
    add_column :posts, :title, :string, after: :isbn
    add_column :posts, :image_url, :string, after: :title
    add_column :posts, :url, :string, after: :image_url
    add_index :posts, :title
  end
end
