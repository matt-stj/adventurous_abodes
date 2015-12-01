class RentalTypeController < ApplicationController
  def show
    @rental_type = find_rental_type_by_name(params[:rental_type_name])
  end
end
