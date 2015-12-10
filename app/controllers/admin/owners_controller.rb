class Admin::OwnersController < Admin::BaseController
  def index
    @owners = User.owners
  end

  def show
    @owner = User.find(params[:id])
  end

  def create
    user = User.find(params[:format])
    user.update_owner_status(params[:owner_status])
    user.update_role
    redirect_to admin_dashboard_path
  end

  def edit
    @owner = User.find(params[:id])
  end

  def update
    @owner = User.find(params[:id])
    @owner.skip_password_validation = true
    if params[:commit]
      if @owner.update(owner_params)
        flash.notice = "Account Updated!"
        redirect_to admin_owner_path(@owner)
      else
        flash.now[:errors] = @owner.errors.full_messages.join(" ,")
        render :edit
      end
    else
      @owner.update_owner_status(params[:owner_status])
      @owner.toggle_rentals(params[:owner_status])
      redirect_to admin_owners_path
    end
  end

  private

  def owner_params
    params.require(:user).permit(:username, :password, :name, :owner_status)
  end
end
