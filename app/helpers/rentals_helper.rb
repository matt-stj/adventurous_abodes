module RentalsHelper
  def purchase_link_or_retired_notice
    if current_user
      if current_user.owner?
        link_to "Edit Rental", edit_owner_rental_path(@rental.id)
      else
        get_purchase_link_or_retired_notice
      end
    else
      get_purchase_link_or_retired_notice
    end
  end

  def get_purchase_link_or_retired_notice
    if @rental.retired?
      content_tag :p, "This rental has been retired and may no longer be purchased."
    else
      link_to "Purchase Trip", new_cart_rental_path(id: @rental.id)
    end
  end
end
