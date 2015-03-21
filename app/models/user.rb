class User < ActiveRecord::Base
  attr_accessor :remember_token

  enum status: { inactive: 0, activation_pending: 1, activated: 2 }
  has_secure_password

  before_save do
    self.email = self.email.downcase
    self.username = self.username.downcase
  end

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 30 }, format: { with: /\A[a-zA-Z][a-zA-Z0-9\-._]+\z/i, allow_blank: true },
            uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.\_]+\.[a-z]+\z/i, allow_blank: true }
  validates :password, length: { minimum: 8 }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
