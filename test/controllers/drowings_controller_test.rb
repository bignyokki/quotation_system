require 'test_helper'

class DrowingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get drowings_create_url
    assert_response :success
  end

end
