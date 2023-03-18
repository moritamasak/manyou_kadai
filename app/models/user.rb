class User < ApplicationRecord
  has_many :tasks,dependent: :destroy
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_destroy :admin_user_null
  def admin_user_null
    throw :abort if self.admin? && User.where(admin: true).count == 1
  end
end
