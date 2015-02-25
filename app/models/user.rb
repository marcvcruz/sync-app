class User < ActiveRecord::Base
  enum status: { inactive: 0, activation_pending: 1, activated: 2 }
  has_secure_password

  before_save do
    self.email = self.email.downcase
    self.username = self.username.downcase
  end

  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 30 }, format: { with: /\A[a-zA-Z][a-zA-Z0-9\-._]+\z/i, allow_empty: true },
            uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, allow_empty: true }
  validates :password, length: { in: 8..30 }
end
