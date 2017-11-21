class Customer < ApplicationRecord
    has_many :orders
    belongs_to :province
    validates :stripe_customer_number, presence: true

    def name
        stripe_customer_number
    end
end
