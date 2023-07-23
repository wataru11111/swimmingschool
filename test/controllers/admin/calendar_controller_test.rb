require "test_helper"

class Admin::CalendarControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_calendar_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_calendar_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_calendar_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_calendar_update_url
    assert_response :success
  end
end
