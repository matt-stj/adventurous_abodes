class RentalsController < ApplicationController
  def index
    @rental_types = RentalType.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  private

  def rental_params
    params.require(:rental).permit(:name, :description, :price, :image)
  end
end
