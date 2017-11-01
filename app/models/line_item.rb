class LineItem < ApplicationRecord
    belongs_to :product
    belongs_to :order
    validates :quantity, :price, :product_id, :discount, presence: true
end
