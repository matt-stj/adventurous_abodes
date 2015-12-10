class Owners::OrdersController < Owners::BaseController
  def index
    @orders = Order.owner_orders(current_user)
  end

  def show
    @order    = Order.find(params[:id])
    @statuses = Order::STATUSES
    @rentals  = @order.gimme_your_rentals(current_user)
  end

  def update
    @order = Order.find(params[:id])
    @order.update_status(params[:order][:status])
    redirect_to owners_order_path(@order)
  end
end
