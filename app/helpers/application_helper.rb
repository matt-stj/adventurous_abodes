module ApplicationHelper
  def login_logout_path
    if current_user
      link_to "Logout", logout_path
    else
      link_to "Login", login_path
    end
  end

  def reservations_display
    link_to "Reservations: #{count_of_trips}", cart_path
  end

  def join_dashboard_path
    if current_owner
      link_to "Logged in as #{current_user.name}", owners_dashboard_path
    elsif current_user
      link_to "Logged in as #{current_user.name}", dashboard_path
    else
      link_to "Not a current member? Join Now!", new_user_path
    end
  end

  def format_currency(price)
    number_to_currency(price, unit: "$")[0...-3]
  end

  def order_date(date)
    date.strftime("%B %d, %Y")
  end

  def order_time(date)
    date.strftime("%H:%M")
  end

  def rental_start_date(date)
    date.sub(',', '')
  end

  def rental_end_date(date)
    date.sub(',', '')
  end

  def order_date_and_time(date)
    "#{order_date(date)} at #{order_time(date)}"
  end
end
