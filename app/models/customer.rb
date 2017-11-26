
require 'bcrypt'
class Customer < ApplicationRecord
    has_many :orders
    belongs_to :province
    validates :email, :province, :password_hash, presence: true

    include BCrypt
      def password
        @password ||= Password.new(password_hash)
      end
    
      def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
      end
end
