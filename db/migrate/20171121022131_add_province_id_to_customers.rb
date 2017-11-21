class AddProvinceIdToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :province_id, :resource
  end
end
