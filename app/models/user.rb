class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: true
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
end
