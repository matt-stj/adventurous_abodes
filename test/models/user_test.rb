require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    create_roles
  end

  def valid_attributes
    {
      name: "Torie",
      username: "Torie@gmail.com",
      password: "password",
      owner_status: nil
    }
  end

  test "user is created with valid attributes" do
    user = User.new(valid_attributes)

    assert user.valid?
    assert_equal "Torie", user.name
    assert_equal "Torie@gmail.com", user.username
    assert_equal "password", user.password
  end

  test "user is invalid with missing name" do
    user = User.new(username: "Torie@gmail.com",
                    password: "password")

    refute user.valid?
  end

  test "user is invalid with missing username" do
    user = User.new(name: "Torie",
                    password: "password")

    refute user.valid?
  end

  test "user is invalid with missing password" do
    user = User.new(name: "Torie",
                    username: "Torie@gmail.com")

    refute user.valid?
  end

  test "user knows if it is a platform admin" do
    user = User.create(valid_attributes)
    user.roles << Role.find_by(title: "platform_admin")

    assert user.platform_admin?
  end

  test "user knows if it is not a platform admin" do
    user = User.create(valid_attributes)

    refute user.platform_admin?
  end

  test "user knows if it is a store admin" do
    user = User.create(valid_attributes)
    user.roles << Role.find_by(title: "owner")

    assert user.owner?
  end

  test "user knows if it is not a store admin" do
    user = User.create(valid_attributes)

    refute user.owner?
  end

  test "user knows if it is a registered user" do
    user = User.create(valid_attributes)
    user.roles << Role.find_by(title: "registered_user")

    assert user.registered_user?
  end

  test "user knows if it is not a registered user" do
    user = User.create(valid_attributes)

    refute user.registered_user?
  end

  test "user knows if it's an active owner" do
    user = User.create(valid_attributes)
    user.owner_status = "active"

    assert user.active?
  end

  test "user knows if it's not an active owner with inactive status" do
    user = User.create(valid_attributes)
    user.owner_status = "inactive"

    refute user.active?
  end

  test "user knows if it's not an active owner with no status" do
    user = User.create(valid_attributes)

    refute user.active?
  end

  test "a new user is assigned the default role" do
    user = User.create(valid_attributes)
    role = Role.find_by(title: "registered_user")

    assert_equal [], user.roles

    user.assign_default_role

    assert_equal role, user.roles.first
  end

  test "a user knows where to redirect to" do
    user = User.create(valid_attributes)

    assert_equal "/dashboard", user.redirect_path
  end

  test "an owner knows where to redirect to" do
    user = User.create(valid_attributes)
    user.roles << Role.find_by(title: "owner")

    assert_equal "/owners/dashboard", user.redirect_path
  end

  test "an admin knows where to redirect to" do
    user = User.create(valid_attributes)
    user.roles << Role.find_by(title: "platform_admin")

    assert_equal "/admin/dashboard", user.redirect_path
  end

  test "a user can be updated to pending" do
    user = User.create(valid_attributes)
    user.update_owner_status("pending")

    assert_equal "pending", user.owner_status
  end

end
