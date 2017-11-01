class Order < ApplicationRecord
    validates :satus, :pst_rate, :gst_rate, :hst_rate, :customer_id, presence: true
end
