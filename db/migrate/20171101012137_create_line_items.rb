class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.decimal :price
      t.integer :product_id
      t.decimal :item_discount

      t.timestamps
    end
  end
end
