class RentalsController < ApplicationController
  def index
    @active_rentals = Rental.active
  end

  def show
    @rental = Rental.find(params[:id])
  end
end
