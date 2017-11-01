class SaleProduct < ApplicationRecord
    validates :name, :description, :discount_percent, :product_id, presence: true
end
