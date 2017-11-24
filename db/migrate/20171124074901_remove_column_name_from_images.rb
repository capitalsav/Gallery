class RemoveColumnNameFromImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :name
  end
end
