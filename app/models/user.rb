class User < ApplicationRecord
    has_secure_password #password setter/encrypter 
    validates :username, presence: true, uniqueness: true

   
    has_many :reviews
    has_many :spells, -> { distinct }, through: :reviews
end
