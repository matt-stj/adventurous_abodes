class Admin::OwnersController < Admin::BaseController
  def index
    @owners = User.joins(:roles).where("title= ?", "owner")
  end

  def show
    @owner = User.find(params[:id])
  end

  def create
    user = User.find(params[:format])
    user.update_attributes!(owner_status: params[:owner_status])
    user.update_role
    redirect_to admin_dashboard_path
  end

  def edit
    @owner = User.find(params[:id])
  end

 def update
   @user = User.find(params[:id])
   if params[:commit]
     if @user.update(owner_params)
       flash.notice = "Account Updated!"
       redirect_to admin_owner_path(@user)
     else
       flash.now[:errors] = @user.errors.full_messages.join(" ,")
       render :edit
     end
   else
    @user.update_attributes!(owner_status: params[:owner_status])
    redirect_to admin_owners_path
  end
 end

 private

   def owner_params
     params.require(:user).permit(:username, :password, :name, :owner_status)
   end
end
