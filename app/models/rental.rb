class Rental < ActiveRecord::Base
  belongs_to :rental_type
  belongs_to :user
  has_many :reservations
  has_many :orders, through: :reservations
  has_attached_file :image, default_url: "http://robbielane.net/works/haines/photos/HainesLutakRoad.jpg"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates :name, :description, :price, presence: true
  # validates :rental_type_id, presence: true
  validates_numericality_of :price, greater_than: 0

  def retire
    self.update(status: "retired")
  end

  def retired?
    status == "retired"
  end
end
