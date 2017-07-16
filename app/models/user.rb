class User < ApplicationRecord
  VALID_EMAIL_EXPR =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 200 }
  validates :email, presence: true, length: { maximum: 255 }

  validates :email, format: { with: VALID_EMAIL_EXPR }
  validates :email, uniqueness: { case_sensitive: false }

  before_save { email.downcase! }

  has_secure_password
end
