ActiveAdmin.register LineItem do
    permit_params :quantity, :price, :product_id, :item_discount
end
