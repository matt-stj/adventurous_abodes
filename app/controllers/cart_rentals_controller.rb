class CartRentalsController < ApplicationController
  def create
    trip = Rental.find(params[:rental_id])

    @cart.add_trip(trip.id)
    @cart.update(trip.id, params[:travellers])

    session[:cart] = @cart.trips
    flash[:notice] = "You have added #{trip.name} to your cart."
    redirect_to rentals_path
  end

  def new
  end

  def show
    @rentals = @cart.rentals_in_cart
  end

  def update
    @cart.update(params[:rental_id], params[:travellers])
    session[:cart] = @cart.trips

    trip_name = Rental.find(params[:rental_id]).name

    flash[:notice] = "You have updated Travellers for the trip #{trip_name} in your cart."
    redirect_to cart_path
  end

  def delete
    trip = Rental.find(params[:rental_id])
    @cart.remove(trip)

    flash[:notice] = "You have removed the trip #{view_context.link_to(trip.name, rental_path(trip))} from your cart."
    redirect_to cart_path
  end
end
