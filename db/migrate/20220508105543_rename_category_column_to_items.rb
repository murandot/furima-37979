class RenameCategoryColumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :category, :category_id
    rename_column :items, :status, :status_id
  end
end
