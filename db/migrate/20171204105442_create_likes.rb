class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :image_id

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :image_id
    add_index :likes, [:user_id, :image_id], unique: true
  end
end
