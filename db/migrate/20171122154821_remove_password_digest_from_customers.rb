class RemovePasswordDigestFromCustomers < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :password_digest, :string
  end
end
