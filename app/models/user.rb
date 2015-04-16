class User < ActiveRecord::Base
  scope :standard_users, -> { where(is_admin: false) }
  attr_accessor :remember_token, :reset_token

  has_secure_password validations: false

  before_save do
    self.email = self.email.downcase
    self.username = self.username.downcase
  end

  validates_presence_of :username, :first_name, :last_name, :email, :password_digest, message: :field_is_required
  validates_length_of :first_name, :last_name, maximum: 50, message: :length_can_not_exceed_max
  validates :username,
            length: { maximum: 30, message: :length_can_not_exceed_max },
            format: { with: /\A[a-z]+[\w\-\.]+\z/i, multiline: false, allow_blank: true, message: :no_spaces_or_special_characters },
            uniqueness: { case_sensitive: false }
  validates :email,
            format: { with: /\A[a-z]+(\_{1}a-z+0-9+)+[\w+\-.]+@[a-z]*[\w]+\.[a-z]+\z/i, allow_blank: true , message: :please_use_a_valid_email_address }
  validates :password,
            length: { minimum: 8, message: :minimum_password_length_requirement, allow_blank: true },
            confirmation: { message: :passwords_do_not_match }

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
