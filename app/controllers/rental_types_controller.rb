class RentalTypesController < ApplicationController
  def index
    @rental_types = RentalType.all
  end

  def show
    @rental_type = RentalType.find(params[:id])
  end
end
