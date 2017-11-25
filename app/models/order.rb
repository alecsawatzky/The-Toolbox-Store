class Order < ApplicationRecord
    has_many :line_items
    belongs_to :customer
    validates :pst_rate, :gst_rate, :hst_rate, :customer_id, presence: true

    def name
        id
    end
end
