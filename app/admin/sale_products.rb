ActiveAdmin.register SaleProduct do
    permit_params :name, :description, :discount_percent, :product_id
end
