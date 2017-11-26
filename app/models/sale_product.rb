class SaleProduct < ApplicationRecord
    belongs_to :product
    validates :name, :discount_percent, :product_id, presence: true
    validates :discount_percent, :inclusion => 1..100
end
