class OwnersController < ApplicationController
  def new
    @owner = User.new
  end

  def create
    @owner = User.new(owner_params)
    if @owner.save
      session[:user_id] = @owner.id
      @owner.roles << Role.find_by(title: "registered_user")
      redirect_to '/pending'
    else
      flash[:notice] = "Invalid credentials. Please try again."
      redirect_to new_owner_path
    end
  end

  def pending
  end

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

  private

    def owner_params
      params.require(:user).permit(:username, :password, :name)
    end
end
