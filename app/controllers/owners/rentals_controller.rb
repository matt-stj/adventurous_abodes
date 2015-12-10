class Owners::RentalsController < Owners::BaseController
  def index
    @rentals = current_user.rentals
  end

  # def show
  #   @rental = Rental.find(params[:id])
  # end

  def new
    @rental = Rental.new
    @rental_types = RentalType.all
  end

  def create

    # rental_type = Rental.create(params[:rental][:rental_type])
    @rental = current_user.rentals.new(rental_params)
    # rental_type = RentalType.find_or_create_by(name: params[:rental][:rental_type])
    # @rental = rental_type.rentals.new(rental_params)
    if @rental.save
      flash[:notice] = "The rental '#{@rental.name}' has been created"
      redirect_to owners_dashboard_path
    else
      flash[:notice] = @rental.errors.full_messages.join(", ")
      redirect_to new_owners_rental_path
    end
  end

  def edit
    @rental = Rental.find(params[:id])
    @rental_types = RentalType.all
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
      flash.notice = "Rental Updated!"
      redirect_to owners_rentals_path
    else
      flash.now[:errors] = @rental.errors.full_messages.join(" ,")
      @rental_types = RentalType.all
      render :edit
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy
    redirect_to owners_rentals_path
  end

  private

  def rental_params
    params.require(:rental).permit(:name, :description, :rental_type_id, :price, :image, :user_id, :status)
  end
end
