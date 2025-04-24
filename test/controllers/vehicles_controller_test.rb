require "test_helper"

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vehicles_index_url
    assert_response :success
  end

  test "should get new" do
    get vehicles_new_url
    assert_response :success
  end

  test "should get create" do
    get vehicles_create_url
    assert_response :success
  end

  test "should get show" do
    get vehicles_show_url
    assert_response :success
  end

  test "should get search" do
    get vehicles_search_url
    assert_response :success
  end

  test "should get results" do
    get vehicles_results_url
    assert_response :success
  end
end
