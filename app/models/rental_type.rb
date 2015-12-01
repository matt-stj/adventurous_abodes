class RentalType < ActiveRecord::Base
  has_many :rentals
end
