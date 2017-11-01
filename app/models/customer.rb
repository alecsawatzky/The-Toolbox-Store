class Customer < ApplicationRecord
    has_many :orders
    validates :stripe_customer_id, presence: true
end
