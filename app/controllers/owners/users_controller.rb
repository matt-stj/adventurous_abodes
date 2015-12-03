class Owners::UsersController < Owners::BaseController
  def show
    @rentals = current_user.rentals
    @owner = current_user
  end

  def dashboard
    @rentals = current_user.rentals
    @owner = current_user
  end
end
