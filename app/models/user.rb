class User < ActiveRecord::Base
  scope :standard_users, -> { where(is_admin: false) }
  attr_accessor :remember_token, :reset_token

  has_secure_password

  before_save do
    self.email = self.email.downcase
    self.username = self.username.downcase
  end

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 30 }, format: { with: /\A[a-zA-Z][a-zA-Z0-9\-._]+\z/i, allow_blank: true },
            uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.\_]+\.[a-z]+\z/i, allow_blank: true }
  validates :password, length: { minimum: 8 }, allow_blank: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.all_except(user)
    where.not id: user
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest,  User.digest(reset_token)
    update_attribute :reset_sent_at, Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
end
