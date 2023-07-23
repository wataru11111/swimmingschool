require "test_helper"

class Public::DateControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_date_new_url
    assert_response :success
  end

  test "should get confirmation" do
    get public_date_confirmation_url
    assert_response :success
  end

  test "should get completion" do
    get public_date_completion_url
    assert_response :success
  end

  test "should get index" do
    get public_date_index_url
    assert_response :success
  end

  test "should get show" do
    get public_date_show_url
    assert_response :success
  end
end
