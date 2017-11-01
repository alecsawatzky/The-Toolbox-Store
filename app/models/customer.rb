class Customer < ApplicationRecord
    has_many :orders
    validates :stripe_customer_number, presence: true
end
