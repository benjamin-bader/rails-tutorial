class User < ApplicationRecord
  VALID_EMAIL_EXPR =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  attr_accessor :remember_token

  validates :name, presence: true, length: { maximum: 200 }
  validates :email, presence: true, length: { maximum: 255 }

  validates :email, format: { with: VALID_EMAIL_EXPR }
  validates :email, uniqueness: { case_sensitive: false }

  before_save { email.downcase! }

  has_secure_password

  # Returns the bcrypt hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
                                                : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random, URL-safe, base-64 token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
    self.remember_token = nil
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
