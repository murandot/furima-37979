class Unknown < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :price_id, :price
  end
end
