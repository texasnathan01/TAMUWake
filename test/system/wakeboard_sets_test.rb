require "application_system_test_case"

class WakeboardSetsTest < ApplicationSystemTestCase
  setup do
    @wakeboard_set = wakeboard_sets(:one)
  end

  test "visiting the index" do
    visit wakeboard_sets_url
    assert_selector "h1", text: "Wakeboard sets"
  end

  test "should create wakeboard set" do
    visit wakeboard_sets_url
    click_on "New wakeboard set"

    fill_in "Current rider count", with: @wakeboard_set.current_rider_count
    fill_in "Rider limit", with: @wakeboard_set.rider_limit
    fill_in "Scheduled date", with: @wakeboard_set.scheduled_date
    click_on "Create Wakeboard set"

    assert_text "Wakeboard set was successfully created"
    click_on "Back"
  end

  test "should update Wakeboard set" do
    visit wakeboard_set_url(@wakeboard_set)
    click_on "Edit this wakeboard set", match: :first

    fill_in "Current rider count", with: @wakeboard_set.current_rider_count
    fill_in "Rider limit", with: @wakeboard_set.rider_limit
    fill_in "Scheduled date", with: @wakeboard_set.scheduled_date
    click_on "Update Wakeboard set"

    assert_text "Wakeboard set was successfully updated"
    click_on "Back"
  end

  test "should destroy Wakeboard set" do
    visit wakeboard_set_url(@wakeboard_set)
    click_on "Destroy this wakeboard set", match: :first

    assert_text "Wakeboard set was successfully destroyed"
  end
end
