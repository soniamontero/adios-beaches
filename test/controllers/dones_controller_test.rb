require 'test_helper'

class DonesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get dones_create_url
    assert_response :success
  end

  test "should get destroy" do
    get dones_destroy_url
    assert_response :success
  end

end
