class Reservation < ActiveRecord::Base
  belongs_to :order
  belongs_to :rental

  def number_of_nights
    (end_date - start_date).to_i
  end
end
