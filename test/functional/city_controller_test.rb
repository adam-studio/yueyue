require 'test_helper'

class CityControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get change_city" do
    get :change_city
    assert_response :success
  end

  test "should get index_by_letter" do
    get :index_by_letter
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end
