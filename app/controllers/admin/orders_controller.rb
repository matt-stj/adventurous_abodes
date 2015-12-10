class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.owner_orders(User.find(params[:owner]))
  end

end
