class Province < ApplicationRecord
    validates :name, :pst, :gst, :hst, presence: true
end
