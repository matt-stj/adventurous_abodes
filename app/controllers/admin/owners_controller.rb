class Admin::OwnersController < Admin::BaseController
  def index
    @owners = User.joins(:roles).where("title= ?", "owner")
  end
end
