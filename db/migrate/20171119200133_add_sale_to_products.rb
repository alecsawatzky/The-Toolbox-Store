class AddSaleToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :sale, :boolean
  end
end
