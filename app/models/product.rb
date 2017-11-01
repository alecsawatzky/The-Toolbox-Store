class Product < ApplicationRecord
    validates :name, :description, :price, :stock_quantity, :category_id, presence: true    
end
