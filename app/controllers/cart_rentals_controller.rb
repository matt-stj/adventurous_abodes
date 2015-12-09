class CartRentalsController < ApplicationController
  def create
    trip = Rental.find(params[:rental_id])
    @start_date = params[:startDate]
    @end_date = params[:endDate]

    @cart.add_trip(trip.id, @start_date, @end_date)

    session[:cart] = @cart.trips
    flash[:notice] = "You have added #{trip.name} to your cart."
    redirect_to rental_types_path
  end

  def new
    today = Date.today
    @black_out_dates = []
    @minimum = [[today.year, today.month-1, today.day]]
    rental = Rental.find(params[:id])
    rental.reservations.each do | reservation |
      if reservation.start_date != nil
        reservation.number_of_nights.times do |i|
          date = reservation.start_date + i.days
          @black_out_dates << [date.year, date.month-1, date.day]
        end
      end
    end
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
