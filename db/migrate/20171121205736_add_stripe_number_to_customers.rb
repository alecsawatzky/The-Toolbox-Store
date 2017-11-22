class AddStripeNumberToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :stripe_identifier, :string
  end
end
