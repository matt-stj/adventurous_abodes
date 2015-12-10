class CartRentalsController < ApplicationController
  before_filter :validate_dates, only: [:create]

  def create
    rental = Rental.find(params[:rental_id])
    @cart.add_trip(rental.id, params[:startDate] , params[:endDate])
    session[:cart] = @cart.trips
    flash[:notice] = "You have added #{rental.name} to your cart."
    redirect_to cart_path
  end

  def new
    today    = Date.today
    @minimum = [[today.year, today.month-1, today.day]]
    rental           = Rental.find(params[:id])
    @black_out_dates = rental.reservation_black_out_dates
  end

  def show
    @rentals = @cart.rentals_in_cart
  end

  def delete
    trip = Rental.find(params[:rental_id])
    @cart.remove(trip)
    flash[:notice] = "You have removed the trip #{view_context.link_to(trip.name, rental_path(trip))} from your cart."
    redirect_to cart_path
  end

  private

  def validate_dates
    rental = Rental.find(params[:rental_id])
    if params[:startDate] != ""
      first_date = Date.parse(params[:startDate])
    end
    if params[:endDate] != ""
      last_date = Date.parse(params[:endDate])
    end
    next_reservation = rental.reservations.where("start_date > ?", first_date ).first

    if first_date == nil || last_date == nil
      redirect_to :back
      flash[:notice] = "You must choose a start and end date"
    elsif first_date >= last_date
      redirect_to :back
      flash[:notice] = "You must end your trip after the start date"
    elsif next_reservation != nil && last_date > next_reservation.start_date
      redirect_to :back
      flash[:notice] = "You must checkout before the next reservation"
    end
  end
end
