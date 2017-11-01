class AddStripeCustomerNumberFromCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :stripe_customer_number, :integer
  end
end
