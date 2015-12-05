class AdminController < ApplicationController
  def show
    @owners = User.pending
  end
end
