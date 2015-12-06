class Owners::OrdersController < Owners::BaseController
  def index
    @orders = Order.owner_orders(current_user)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    valid = ["Paid", "Cancelled", "Completed", "Pending"]
    if valid.include?(params[:order_status])
      @order.update_status(params[:order_status])
    else
      flash[:notice] = "Invalid Order Status"
    end
    redirect_to owners_order_path(@order)
  end
end
