require "test_helper"

class WakeboardSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wakeboard_set = wakeboard_sets(:one)
  end

  test "should get index" do
    get wakeboard_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_wakeboard_set_url
    assert_response :success
  end

  test "should create wakeboard_set" do
    assert_difference("WakeboardSet.count") do
      post wakeboard_sets_url, params: { wakeboard_set: { current_rider_count: @wakeboard_set.current_rider_count, rider_limit: @wakeboard_set.rider_limit, scheduled_date: @wakeboard_set.scheduled_date } }
    end

    assert_redirected_to wakeboard_set_url(WakeboardSet.last)
  end

  test "should show wakeboard_set" do
    get wakeboard_set_url(@wakeboard_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_wakeboard_set_url(@wakeboard_set)
    assert_response :success
  end

  test "should update wakeboard_set" do
    patch wakeboard_set_url(@wakeboard_set), params: { wakeboard_set: { current_rider_count: @wakeboard_set.current_rider_count, rider_limit: @wakeboard_set.rider_limit, scheduled_date: @wakeboard_set.scheduled_date } }
    assert_redirected_to wakeboard_set_url(@wakeboard_set)
  end

  test "should destroy wakeboard_set" do
    assert_difference("WakeboardSet.count", -1) do
      delete wakeboard_set_url(@wakeboard_set)
    end

    assert_redirected_to wakeboard_sets_url
  end
end
