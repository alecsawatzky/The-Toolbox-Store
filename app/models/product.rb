class Product < ApplicationRecord
    belongs_to :category
    has_one :sale_product
    has_many :line_items
    validates :name, :description, :price, :stock_quantity, :category_id, presence: true    
    validates :name, uniqueness: {message: "An existing product has the same name." }
    mount_uploader :image, AvatarUploader
end
