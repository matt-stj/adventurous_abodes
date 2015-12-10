class RentalType < ActiveRecord::Base
  has_many :rentals
  before_validation :generate_slug
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  def generate_slug
    self.slug = name.parameterize
  end

  def active_rentals
    self.rentals.active
  end
end
