class OwnerController < ApplicationController
  before_action :require_owner

  def dashboard
    @rentals = current_user.rentals
    @owner = current_user
    #@statuses = ["Completed", "Pending", "Paid", "Cancelled"]
  end
end
