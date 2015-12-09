module RentalsHelper
  def purchase_link_or_retired_notice
      if current_user.owner?
        link_to "Edit Rental", edit_owners_rental_path(@rental.id)
      end
  end

  def get_purchase_link_or_retired_notice
    if @rental.retired?
      content_tag :p, "This rental has been retired and may no longer be purchased."
    else
      link_to "Reserve it!", new_cart_rental_path(id: @rental.id)
    end
  end
end
