ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "mocha/mini_test"
require "minitest/pride"
require "simplecov"

SimpleCov.start "rails"

class ActiveSupport::TestCase
  def setup
    create_roles
  end

  def create_roles
    Role.create(title: "platform_admin")
    Role.create(title: "owner")
    Role.create(title: "registered_user")
  end

  def create_user
    Role.create(title: "registered_user")
    user = User.create!(username: "cole", name: "Nicole", password: "password")
    user.roles << Role.find_by(title: "registered_user")
    user
  end

  def create_rental
    rental_type = RentalType.create!(name: 'my rental type')
    rental_type.rentals.create(name: "Name Rental",
                              description: "Description",
                              price: 1000 )
  end

end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    create_roles
    create_rental_types
  end

  def create_rental_types
    RentalType.create(name: "Castle")
  end

  def create_roles
    Role.create(title: "platform_admin")
    Role.create(title: "owner")
    Role.create(title: "registered_user")
  end

  def create_user
    user = User.create!(username: "cole", name: "Nicole", password: "password")
    user.roles << Role.find_by(title: "registered_user")
    user
  end

  def create_and_login_user
    @user = create_user
    visit login_path
    fill_in "Username", with: @user.username
    fill_in "Password", with: "password"
    click_button "Login"
  end

  def create_owners(number_of_owners, status)
    number_of_owners.times do |i|
      owner = User.create!(username: "owner#{i}", name: "owner#{i}", password: "password")
      owner.roles << Role.find_by(title: "owner")
      owner.update_attributes(owner_status: status)
    end
    User.last
  end

  def create_and_login_owner
    @owner = create_owners(1, "active")
    visit login_path
    fill_in "Username", with: @owner.username
    fill_in "Password", with: "password"
    click_button "Login"
  end

  def create_rentals(num, rental_type)
    @owner = create_owners(1, "active")
    num.times do |i|
      i += 1
      rental_type = RentalType.find_or_create_by(name: rental_type)
      rental = rental_type.rentals.create(name: "Name #{i}",
                               description: "Description #{i}",
                               price: 1000 + i)
      @owner.rentals << rental
    end
  end

  def add_item_to_cart
    create_rentals(1, "Castle")
    rental = RentalType.find_by_name("Castle").rentals.first
    visit rental_path(rental)
    click_link "Reserve it!"
    fill_in "startDate", with: "Dec 26, 2015"
    fill_in "endDate",   with: "Jan 01, 2016"
    click_button "Place Order"
  end

  def add_second_item_to_cart
    create_rentals(1, "Shack")
    rental = RentalType.find_by_name("Shack").rentals.first
    visit rental_path(rental)
    click_link "Reserve it!"
    fill_in "startDate", with: "Jan 02, 2016"
    fill_in "endDate",   with: "Jan 07, 2016"
    click_button "Place Order"
  end

  def checkout_user
    create_and_login_user
    add_item_to_cart
    visit "/cart"
    click_button "Checkout"
  end

  def checkout_user_and_login_owner
    checkout_user
    click_link "Logout"
    create_and_login_owner
  end

  def create_platform_admin
    user = User.create!(username: "platform_admin", name: "platform_admin", password: "password")
    user.roles << Role.find_by(title: "platform_admin")
  end

  def login_platform_admin
    visit login_path
    fill_in "Username", with: "platform_admin"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  def create_orders
    checkout_user
  end

  def teardown
    reset_session!
  end
end
