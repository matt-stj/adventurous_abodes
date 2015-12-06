class Admin::OwnersController < Admin::BaseController
  def index
    @owners = User.joins(:roles).where("title= ?", "owner")
  end

  def create
    user = User.find(params[:format])
    user.update_attributes!(owner_status: params[:owner_status])
    user.update_role
    redirect_to admin_dashboard_path
  end

 def update
   user = User.find(params[:id])
   user.update_attributes!(owner_status: params[:owner_status])
   user.toggle_rentals(params[:owner_status])
   redirect_to admin_owners_path
 end
end
