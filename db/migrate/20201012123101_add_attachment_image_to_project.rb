class AddAttachmentImageToProject < ActiveRecord::Migration[5.2]
  def change
    def self.up
      change_table :users do |t|
        t.attachment :image
      end
    end

    def self.down
      remove_attachment :users, :image
    end
  end
end
