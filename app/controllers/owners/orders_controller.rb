class Owners::OrdersController < Owners::BaseController
  def index
    @orders = Order.owner_orders(current_user)
  end

  def show
    @order = Order.find(params[:id])
    @statuses = Order::STATUSES
    @rentals = @order.rentals.where(id: current_user.rentals.map { |rental| rental.id})
  end

  def update
    @order = Order.find(params[:id])
    if Order::STATUSES.include?(params[:order][:status])
      @order.update_status(params[:order][:status])
    else
      flash[:notice] = "Invalid Order Status"
    end
    redirect_to owners_order_path(@order)
  end
end
