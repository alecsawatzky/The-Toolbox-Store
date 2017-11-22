class RemoveStripeCustomerNumberFromCustomers < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :stripe_customer_number, :integer
  end
end
