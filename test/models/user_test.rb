require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def valid_attributes
    {
      name: "Torie",
      username: "Torie@gmail.com",
      password: "password"
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
    create_roles
    user = User.create(valid_attributes)
    user.roles << Role.find_by(title: "platform_admin")

    assert user.platform_admin?
  end

  test "user knows if it is not a platform admin" do
    create_roles
    user = User.create(valid_attributes)

    refute user.platform_admin?
  end

  test "user knows if it is a store admin" do
    create_roles
    user = User.create(valid_attributes)
    user.roles << Role.find_by(title: "store_admin")

    assert user.store_admin?
  end

  test "user knows if it is not a store admin" do
    create_roles
    user = User.create(valid_attributes)

    refute user.store_admin?
  end

  test "user knows if it is a registered user" do
    create_roles
    user = User.create(valid_attributes)
    user.roles << Role.find_by(title: "registered_user")

    assert user.registered_user?
  end

  test "user knows if it is not a registered user" do
    create_roles
    user = User.create(valid_attributes)

    refute user.registered_user?
  end

end
