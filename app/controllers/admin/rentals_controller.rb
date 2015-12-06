class Admin::RentalsController < Admin::BaseController

  def edit
    @owner = User.find(params[:owner])
    @rental = Rental.find(params[:id])
  end

  def update
    owner = User.find(params[:rental][:owner_id])
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
      flash.notice = "Rental Updated!"
      redirect_to admin_owner_path(owner)
    else
      flash.now[:errors] = @rental.errors.full_messages.join(" ,")
      render :edit
    end
  end

  private

    def rental_params
      params.require(:rental).permit(:name, :description, :price, :image, :user_id)
    end
end
