require 'test_helper'

class OwnerIndexTest < ActionDispatch::IntegrationTest
  test "when a guest visits /owners, they see a list of all owners" do
    create_owners(5, "active")
    visit root_url
    click_button("View All Owners")

    assert_equal owners_path, current_path
    assert page.has_content?("owner0")
    assert page.has_content?("owner1")
    assert page.has_content?("owner2")
    assert page.has_content?("owner3")
    assert page.has_content?("owner4")
  end

  test "when a guest visits /owners, they can click a link to visit the owner's show page" do
    create_owners(5, "active")
    visit root_url
    click_button("View All Owners")
    assert_equal owners_path, current_path
    assert page.has_link?("owner0")
    click_link("owner0")

    assert_equal owner_path(User.find_by(name: "owner0")),current_path
  end
end
