class OwnersController < ApplicationController

  def index
    @users = User.all
    @owners = []
    @users.map do |user|
      if user.owner?
        @owners << user
      end
    end
    @owners
  end

  def show
    @owner = User.find(params[:id])
  end
end
