require "test_helper"

class Public::OffsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_offs_index_url
    assert_response :success
  end

  test "should get new" do
    get public_offs_new_url
    assert_response :success
  end
end
