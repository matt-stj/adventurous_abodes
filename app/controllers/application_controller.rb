class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  before_action :authorize!

  helper_method :format_url_name, :count_of_trips,
                :rentals_in_cart, :current_user, :current_owner

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def format_url_name(name)
    name.downcase.gsub(" ", "_")
  end

  def count_of_trips
    @cart.total_trips
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_owner
    current_user && current_user.owner?
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    unless authorized?
      flash[:notice] = "Back Off!"
      redirect_to root_path
    end
  end

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end


  def require_owner
    render file: "./test/public/404" unless current_owner
  end

  def require_platform_admin
    render file: "./test/public/404" unless platform_admin
  end
  
end
