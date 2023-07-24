require "test_helper"

class Public::ChildControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_child_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_child_edit_url
    assert_response :success
  end
end
