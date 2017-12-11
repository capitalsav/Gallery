class CreateAvatars < ActiveRecord::Migration[5.1]
  def change
    create_table :avatars do |t|
      t.string :image
      t.integer :user_id

      t.timestamps
    end
    add_index :avatars, [:image, :user_id], unique: true
  end
end
