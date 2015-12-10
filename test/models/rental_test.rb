require "test_helper"

class RentalTest < ActiveSupport::TestCase
  def setup
    RentalType.create(name: "Castle")
  end

  def default_image_url
    ":thumbnail/house-06.jpg"
  end

  def valid_attributes
    {
      name:           "Name Castle",
      description:    "No Dragons allowed!",
      price:          1001,
      rental_type_id: RentalType.find_by_name("Castle").id
    }
  end

  test "a valid rental can be created" do
    rental = Rental.new(valid_attributes)
    assert rental.valid?
  end

  test "it is invalid with missing name" do
    rental = Rental.new(description: "No Dragons allowed!",
                        price: 1001,
                        rental_type_id: RentalType.find_by_name("Castle").id)

    refute rental.valid?
  end

  test "it is invalid with missing description" do
    rental = Rental.new(name: "Name Castle",
                        price: 1001,
                        rental_type_id: RentalType.find_by_name("Castle").id)

    refute rental.valid?
  end

  test "it is invalid with missing price" do
    rental = Rental.new(name: "Name Castle",
                          description: "No Dragons allowed!",
                          rental_type_id: RentalType.find_by_name("Castle").id)

    refute rental.valid?
  end

  test "it must belong to an rental_type" do
    rental = Rental.new(name: "Name Castle",
                        description: "No Dragons allowed!",
                        price: 1000)

    refute rental.valid?
  end

  test "it must have a price that is greater than zero" do
    rental = Rental.new( { name: "Name Castle",
                           description: "No Dragons allowed!",
                           price: -1,
                           rental_type_id: RentalType.find_by_name("Castle").id
                         })

    refute rental.valid?
  end

  test "default photo is provided if no photo is specified" do
    rental = Rental.new(valid_attributes)

    assert_equal default_image_url, rental.image.url
  end

  test "it can be retired" do
    rental = Rental.new(valid_attributes)
    rental.retire

    assert rental.retired?
  end

  test "rental knows it's owners name" do
    owner = create_user
    rental = Rental.new(valid_attributes)
    rental.user_id = owner.id

    assert "Nicole", rental.owner_name
  end

  test "rental knows it's owners username" do
    owner = create_user
    rental = Rental.new(valid_attributes)
    rental.user_id = owner.id

    assert "Nicole", rental.owner_name
  end
end
