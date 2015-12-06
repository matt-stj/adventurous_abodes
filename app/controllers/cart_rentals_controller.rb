class CartRentalsController < ApplicationController
  def create
    trip = Rental.find(params[:rental_id])
    @start_date = params[:startDate]
    @end_date = params[:endDate]

    @cart.add_trip(trip.id, @start_date, @end_date)

    session[:cart] = @cart.trips
    flash[:notice] = "You have added #{trip.name} to your cart."
    redirect_to rentals_path
  end

  def new
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
end
