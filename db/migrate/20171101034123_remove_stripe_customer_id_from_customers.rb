class RemoveStripeCustomerIdFromCustomers < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :stripe_customer_id, :integer
  end
end
