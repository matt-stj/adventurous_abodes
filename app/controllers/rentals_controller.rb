class RentalsController < ApplicationController
  def index
    @rental_types = RentalType.all
  end

  def show
    @rental = Rental.find(params[:id])
  end
end
