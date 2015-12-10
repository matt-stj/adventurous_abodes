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
    today = Date.today
    @minimum = [[today.year, today.month-1, today.day]]
    @rental = Rental.find(params[:id])
    @black_out_dates = @rental.reservation_black_out_dates
  end

  def show
    @rentals = @cart.rentals_in_cart
  end

  def delete
    rental = Rental.find(params[:rental_id])
    @cart.remove(rental)
    flash[:notice] = "You have removed the #{(rental.name)} from your cart."
    redirect_to cart_path
  end

  private

  def validate_dates
    if parsed_start_date == nil || parsed_end_date == nil
      redirect_to :back
      flash[:notice] = "You must choose a start and end date"
    elsif parsed_start_date >= parsed_end_date
      redirect_to :back
      flash[:notice] = "You must end your trip after the start date"
    elsif next_reservation != nil && parsed_end_date > next_reservation.start_date
      redirect_to :back
      flash[:notice] = "You must checkout before the next reservation"
    end
  end

  def parsed_start_date
    Date.parse(params[:startDate]) if params[:startDate] != ""
  end

  def parsed_end_date
    Date.parse(params[:endDate]) if params[:endDate] != ""
  end

  def next_reservation
    rental = Rental.find(params[:rental_id])
    rental.reservations.where("start_date > ?", parsed_start_date ).first
  end
end
