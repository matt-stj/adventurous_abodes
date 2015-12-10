class RentalsController < ApplicationController
  def show
    @rental = Rental.find(params[:id])
  end

end
