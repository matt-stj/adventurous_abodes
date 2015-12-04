require 'test_helper'

class PlatformAdminApprovesNewBusinessTest < ActionDispatch::IntegrationTest
  test "A platform admin can see pending requests to become a new owner/host" do
    platform_admin = create_platform_admin
    login_platform_admin

    visit 'admin/dashboard'

    assert page.has_content?("Pending Owner Requests")
  end
end
