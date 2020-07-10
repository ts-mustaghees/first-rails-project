class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :posts

  validates :name, length: { maximum: 50 }, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 },
            presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  
  has_secure_password
end
