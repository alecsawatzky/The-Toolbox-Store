class Customer < ApplicationRecord
    has_many :orders
    belongs_to :province
    validates :email, presence: true

    def name
        stripe_customer_number
    end
end
