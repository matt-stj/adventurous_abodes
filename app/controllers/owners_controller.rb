class OwnersController < ApplicationController
  def new
    @owner = User.new
  end

  def create
    @owner = User.new(owner_params)
    if @owner.save
      session[:user_id] = @owner.id
      @owner.roles << Role.find_by(title: "registered_user")
      @owner.update_attribute(:owner_status, "pending")
      redirect_to '/pending'
    else
      flash[:notice] = "Invalid credentials. Please try again."
      redirect_to new_owner_path
    end
  end

  def edit
    @owner = current_user
  end

  def update
    current_user.update_attribute(:owner_status, "pending")
    redirect_to '/pending'
  end

  def pending
  end

  def index
    @owners = User.active_owners
  end

  def show
    @owner = User.find(params[:id])
  end

  private

    def owner_params
      params.require(:user).permit(:username, :password, :name)
    end
end
