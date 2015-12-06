class PermissionService
  extend Forwardable

  attr_reader :user, :controller, :action
  def_delegators :user, :platform_admin?, :owner?, :registered_user?

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
    case
    when platform_admin?      then platform_admin_permissions
    when owner?               then owner_permissions
    when registered_user?     then registered_user_permissions
    else
      default_permissions
    end
  end

  private

    def platform_admin_permissions
      return true if controller == "admin" && action == "show"
      return true if controller == "admin/owners" && action.in?(%w(index show edit update create))
      return true if controller == "admin/rentals" && action.in?(%w(edit update))
      owner_permissions
    end

    def owner_permissions
      return true if controller == "owners/users" && action == "dashboard"
      return true if controller == "owners/rentals" && action.in?(%w(index show new create edit update destroy))
      return true if controller == "owners/orders" && action.in?(%w(index show new create edit update destroy))
      registered_user_permissions
    end

    def registered_user_permissions
      return true if controller == "orders" && action.in?(%w(index show))
      return true if controller == "users" && action.in?(%w(index show edit update destroy dashboard))
      return true if controller == "sessions" && action == "delete"
      return true if controller == "owners" && action.in?(%w(pending edit update))
      default_permissions
    end

    def default_permissions
      return true if controller == "users" && action.in?(%w(new create))
      return true if controller == "orders" && action.in?(%w(create))
      return true if controller == "sessions" && action.in?(%w(new create))
      return true if controller == "cart_rentals" && action.in?(%w(new show create update delete))
      return true if controller == "rental_types" && action.in?(%w(index show))
      return true if controller == "rentals"      && action.in?(%w(index show))
      return true if controller == "home"         && action == "index"
      return true if controller == "owners" && action.in?(%w(new index show create))
    end

end
