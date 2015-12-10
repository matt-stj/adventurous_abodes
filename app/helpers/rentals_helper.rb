module RentalsHelper
  def purchase_link_or_retired_notice
      if current_user.owner?
        link_to "Edit Rental", edit_owners_rental_path(@rental.id)
      end
  end
end
