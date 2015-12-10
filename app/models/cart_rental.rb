class CartRental
  def self.validate_dates(start_date, end_date, rental_id)
    if parsed_start_date(start_date) == nil || parsed_end_date(end_date) == nil
      "You must choose a start and end date"
    elsif parsed_start_date(start_date) >= parsed_end_date(end_date)
      "You must end your trip after the start date"
    elsif next_reservation(rental_id, start_datgit se) != nil && parsed_end_date(end_date) > next_reservation(rental_id, start_date).start_date
      "You must checkout before the next reservation"
    end
  end

  def self.parsed_start_date(start_date)
    Date.parse(start_date) if start_date != ""
  end

  def self.parsed_end_date(end_date)
    Date.parse(end_date) if end_date != ""
  end

  def self.next_reservation(rental_id, start_date)
    rental = Rental.find(rental_id)
    start = parsed_start_date(start_date)
    rental.reservations.where("start_date > ?", start ).first
  end
end
