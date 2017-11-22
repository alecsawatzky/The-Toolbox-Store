class RemoveStripeCustomerNumberFromCustomers < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :StripeCustomerNumber, :integer
  end
end
