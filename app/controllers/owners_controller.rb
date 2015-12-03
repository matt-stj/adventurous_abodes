class OwnersController < ApplicationController

  def index
    @owners = User.where(role: "store_admin")
  end

  def show
    @owner = User.find(params[:id])
  end
end
