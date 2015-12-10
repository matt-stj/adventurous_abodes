class Reservation < ActiveRecord::Base
  belongs_to :order
  belongs_to :rental

  def number_of_nights
    (end_date - start_date).to_i
  end

  def subtotal
    number_of_nights * price
  end

  def reserved_dates
    dates = []
    number_of_nights.times do |i|
      date = start_date + i.days
      dates << [date.year, date.month-1, date.day]
    end
    dates
  end
end
