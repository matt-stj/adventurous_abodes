class User < ActiveRecord::Base
  has_many :orders
  has_many :rentals
  has_secure_password

  validates :username, presence: true
  validates :name, presence: true
  validates :password, presence: true

  def owner?
    role == 1
  end
end
