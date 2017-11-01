class SaleProduct < ApplicationRecord
    belongs_to :product
    validates :name, :description, :discount_percent, :product_id, presence: true
end
