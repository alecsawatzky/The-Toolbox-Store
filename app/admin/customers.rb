ActiveAdmin.register Customer do
    permit_params :stripe_identifier, :name, :email, :province_id, :password_hash
end
