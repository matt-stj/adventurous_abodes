class RentalTypesController < ApplicationController
  def index
    @rental_types = RentalType.all
  end

  def show
    @rental_type = find_rental_type_by_name(params[:rental_type_name])
  end
end
