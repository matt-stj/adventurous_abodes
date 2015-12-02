require "test_helper"

class RentalTest < ActiveSupport::TestCase
  def setup
    RentalType.create(name: "Hiking")
  end

  def default_image_url
    "http://robbielane.net/works/haines/photos/HainesLutakRoad.jpg"
  end

  def valid_attributes
    {
      name: "Hiking in the Alps",
      description: "Hike The Alps!",
      price: 1001,
      rental_type_id: RentalType.find_by_name("Hiking").id
    }
  end

  test "a valid rental can be created" do
    rental = Rental.new(valid_attributes)
    assert rental.valid?
  end

  test "it is invalid with missing name" do
    skip
    rental = Rental.new(description: "Hike The Alps!",
                          price: 1001,
                          rental_type_id: RentalType.find_by_name("Hiking").id)

    refute rental.valid?
  end

  test "it is invalid with missing description" do
    skip
    rental = Rental.new(name: "Hiking in the alps",
                          price: 1001,
                          rental_type_id: RentalType.find_by_name("Hiking").id)

    refute rental.valid?
  end

  test "it is invalid with missing price" do
    skip
    rental = Rental.new(name: "Hiking in the alps",
                          description: "Hike The Alps!",
                          rental_type_id: RentalType.find_by_name("Hiking").id)

    refute rental.valid?
  end

  test "it must belong to an rental_type" do
    skip
    rental = Rental.new(name: "Hiking in the alps",
                          description: "Hike the Alps!",
                          price: 1000)

    refute rental.valid?
  end

  # test "it must have a unique name" do
  #   rental = Rental.create(valid_attributes)
  #   rental = Rental.new(valid_attributes)
  #
  #   refute rental.valid?
  # end

  test "it must have a price that is greater than zero" do
    skip
    rental = Rental.new( { name: "Hiking in the Alps",
                             description: "Hike The Alps!",
                             price: -1,
                             rental_type_id: RentalType.find_by_name("Hiking").id
                           })

    refute rental.valid?
  end

  test "default photo is provided if no photo is specified" do
    rental = Rental.new(valid_attributes)

    assert_equal default_image_url, rental.image.url
  end
end
