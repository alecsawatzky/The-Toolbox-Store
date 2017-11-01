class CreateSaleProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :sale_products do |t|
      t.string :name
      t.string :description
      t.decimal :discount_percent
      t.integer :product_id

      t.timestamps
    end
  end
end
