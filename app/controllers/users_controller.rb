class UsersController < ApplicationController
  def new
    @new_user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      @user.assign_default_role
      redirect_to "/dashboard"
    else
      flash[:notice] = "Invalid user credentials. Please try again."
      redirect_to login_path
    end
  end

  def dashboard
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash.notice = "Account Updated!"
      redirect_to dashboard_path
    else
      flash.now[:errors] = @user.errors.full_messages.join(" ,")
      render :edit
    end
  end

  def destroy
    current_user.roles = []
    current_user.rentals = []
    current_user.destroy
    session.clear
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :name)
      # params.require(:user).permit(:username, :password, :name, :owner_status)
    end
end
