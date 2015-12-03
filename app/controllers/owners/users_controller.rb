class Owners::UsersController < Owners::BaseController
  def dashboard
    @rentals = current_user.rentals
    @owner = current_user
  end
end
