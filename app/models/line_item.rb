class LineItem < ApplicationRecord
    validates :quantity, :price, :product_id, :discount, presence: true
end
