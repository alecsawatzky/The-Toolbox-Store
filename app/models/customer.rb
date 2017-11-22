class Customer < ApplicationRecord
    has_many :orders
    belongs_to :province
    validates :email, presence: true
    # has_secure_password

    def name
        email
    end
end
