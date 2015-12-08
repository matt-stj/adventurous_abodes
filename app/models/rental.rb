class Rental < ActiveRecord::Base
  belongs_to :rental_type
  belongs_to :user
  has_many :reservations
  has_many :orders, through: :reservations
  has_attached_file :image, :styles => {:original => '800x400>', :thumbnail => '500x250>'}, default_url: ":thumbnail/house-06.jpg"

  #overwrite original size

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates :name, :description, :price, presence: true
  # validates :rental_type_id, presence: true
  # validates_numericality_of :price, greater_than: 0

  scope :active, -> { where status: 'active' }


  def retire
    self.update(status: "retired")
  end

  def retired?
    status == "retired"
  end
end
