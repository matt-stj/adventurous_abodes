class OwnersController < ApplicationController
  def new
    @owner = User.new
  end

  def create
    @owner = User.new(owner_params)
    if @owner.save
      session[:user_id] = @owner.id
      @owner.roles << Role.find_by(title: "registered_user")
      #need to somehow indicate that they are pending for platform_admin
      #maybe a @owner.status = "pending"
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
    # uncomment out the below when new column is added
    # current_user.status = "pending"
    redirect_to '/pending'
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
