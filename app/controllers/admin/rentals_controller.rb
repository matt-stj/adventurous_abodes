class Admin::RentalsController < Admin::BaseController
  def index
    @activities = Activity.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
  end

  def create
    activity = Activity.find_or_create_by(name: params[:rental][:activity])
    @rental = activity.rentals.new(rental_params)
    if @rental.save
      flash[:notice] = "The rental '#{@rental.name}' has been created"
      redirect_to admin_rentals_path
    else
      flash[:notice] = @rental.errors.full_messages.join(", ")
      redirect_to new_admin_rental_path
    end
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
      flash.notice = "Rental Updated!"
      redirect_to admin_rentals_path
    else
      flash.now[:errors] = @rental.errors.full_messages.join(" ,")
      render :edit
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    @rental.destroy
    redirect_to admin_rentals_path
  end

  private

  def rental_params
    params.require(:rental).permit(:name, :description, :price, :image)
  end
end
