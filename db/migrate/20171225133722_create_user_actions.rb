class CreateUserActions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_actions do |t|
      t.integer :user_id
      t.string :action_type
      t.string :url
      t.timestamp :timestamp

      t.timestamps
    end
  end
end
