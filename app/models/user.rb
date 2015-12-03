class User < ActiveRecord::Base
  has_many :orders
  has_many :rentals
  has_many :user_roles
  has_many :roles, through: :user_roles

  has_secure_password

  validates :username, presence: true
  validates :name, presence: true
  validates :password, presence: true

  def platform_admin?
    roles.exists?(title: "platform_admin")
  end

  def owner?
    roles.exists?(title: "owner")
  end

  def registered_user?
    roles.exists?(title: "registered_user")
  end
end
