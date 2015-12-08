require 'test_helper'

class OwnerRentalItemsCanBeToggledTest < ActionDispatch::IntegrationTest
  test "Owner property becomes inactive when owner's status is inactive" do
    create_user
    platform_admin = create_platform_admin

    create_rentals(1, "Castle")
    owner = User.last
    owner_id = owner.id
    owner.update_attributes(owner_status: "active")

    assert_equal "active", owner.owner_status

    assert_equal "active", owner.rentals.first.status

    login_platform_admin

    # visit 'admin/dashboard'

    click_link("Manage Owners")

    within(".owners") do
      assert page.has_content?("active")
    end

    click_link("make-inactive")

    within(".owners") do
      assert page.has_content?("inactive")
    end

    owner = User.find(owner_id)

    assert_equal "inactive", owner.rentals.first.status

  end

  test "Owner property becomes active when owner's status is changed from inactive to active" do
    create_user
    platform_admin = create_platform_admin

    create_rentals(1, "Castle")
    owner = User.last
    owner.update_attribute(:owner_status, "inactive")
    owner.rentals.first.update_attribute(:status, "inactive")

    assert_equal "inactive", owner.owner_status

    assert_equal "inactive", owner.rentals.first.status

    login_platform_admin

    # visit 'admin/dashboard'

    click_link("Manage Owners")

    within(".owners") do
      assert page.has_content?("inactive")
    end

    click_link("make-active")

    within(".owners") do
      assert page.has_content?("active")
    end

    assert_equal "active", owner.rentals.first.status

  end

  test "Multiple owner properties become inactive when owner's status is inactive" do
    create_user
    platform_admin = create_platform_admin

    create_rentals(3, "Castle")
    owner = User.last
    owner_id = owner.id
    owner.update_attributes(owner_status: "active")

    assert_equal "active", owner.owner_status

    assert_equal ["active", "active", "active"], owner.rentals.map { |rental| rental.status }

    login_platform_admin

    # visit 'admin/dashboard'

    click_link("Manage Owners")

    within(".owners") do
      assert page.has_content?("active")
    end

    click_link("make-inactive")

    within(".owners") do
      assert page.has_content?("inactive")
    end

    owner = User.find(owner_id)

    assert_equal ["inactive", "inactive", "inactive"], owner.rentals.map { |rental| rental.status }

  end

  test "Multiple Owner properties become active when owner's status is changed from inactive to active" do
    create_user
    platform_admin = create_platform_admin

    create_rentals(3, "Castle")
    owner = User.last
    owner_id = owner.id
    owner.update_attribute(:owner_status, "inactive")
    owner.rentals.update_all(status: "inactive")

    assert_equal "inactive", owner.owner_status

    assert_equal ["inactive", "inactive", "inactive"], owner.rentals.map { |rental| rental.status }

    login_platform_admin

    # visit 'admin/dashboard'

    click_link("Manage Owners")

    within(".owners") do
      assert page.has_content?("inactive")
    end

    click_link("make-active")

    within(".owners") do
      assert page.has_content?("active")
    end

    owner = User.find(owner_id)

    assert_equal ["active", "active", "active"], owner.rentals.map { |rental| rental.status }
  end

  test "An owner's properties are not shown when their status is inactive" do
    create_user
    platform_admin = create_platform_admin
    login_platform_admin
    create_rentals(3, "Castle")
    owner = User.last
    owner_id = owner.id
    owner.update_attributes(owner_status: "active")

    assert_equal "active", owner.owner_status
    assert_equal ["active", "active", "active"], owner.rentals.map { |rental| rental.status }

    visit rentals_path

    assert page.has_content?(owner.rentals.first.name)
    assert page.has_content?(owner.rentals.last.name)

    visit 'admin/dashboard'
    click_link("Manage Owners")
    click_link("make-inactive")

    owner = User.find(owner_id)

    assert_equal "inactive", owner.owner_status
    assert_equal ["inactive", "inactive", "inactive"], owner.rentals.map { |rental| rental.status }

    visit rentals_path

    refute page.has_content?(owner.rentals.first.name)
    refute page.has_content?(owner.rentals.last.name)
  end

end
