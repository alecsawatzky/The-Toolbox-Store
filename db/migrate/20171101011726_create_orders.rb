class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.decimal :pst_rate
      t.decimal :gst_rate
      t.decimal :hst_rate
      t.integer :customer_id
      t.decimal :discount

      t.timestamps
    end
  end
end
