class User < ApplicationRecord
  before_create :substantiate_api_key
  has_secure_password
  validates :password, confirmation: true
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  has_many :favorites

  private
  def substantiate_api_key
    self.api_key = SecureRandom.hex(5)
  end
end
