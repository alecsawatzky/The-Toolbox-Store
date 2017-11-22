ActiveAdmin.register Customer do
    permit_params :stripe_identifier, :email, :province_id
end
