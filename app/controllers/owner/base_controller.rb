class Owner::BaseController < ApplicationController
  before_action :require_owner
end
