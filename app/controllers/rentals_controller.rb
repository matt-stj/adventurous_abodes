class RentalsController < ApplicationController
  def index
    @activities = Activity.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  private

  def rental_params
    params.require(:rental).permit(:name, :description, :price, :image)
  end
end
