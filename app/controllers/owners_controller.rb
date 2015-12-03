class OwnersController < ApplicationController
  def show
    @owner = User.find(params[:id])
  end
end
