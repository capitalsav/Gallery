class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :user_id
      t.integer :image_id

      t.timestamps
    end
    add_index :comments, :image_id
  end
end
