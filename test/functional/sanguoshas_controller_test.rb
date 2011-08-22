require 'test_helper'

class SanguoshasControllerTest < ActionController::TestCase
  setup do
    @sanguosha = sanguoshas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sanguoshas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sanguosha" do
    assert_difference('Sanguosha.count') do
      post :create, :sanguosha => @sanguosha.attributes
    end

    assert_redirected_to sanguosha_path(assigns(:sanguosha))
  end

  test "should show sanguosha" do
    get :show, :id => @sanguosha.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sanguosha.to_param
    assert_response :success
  end

  test "should update sanguosha" do
    put :update, :id => @sanguosha.to_param, :sanguosha => @sanguosha.attributes
    assert_redirected_to sanguosha_path(assigns(:sanguosha))
  end

  test "should destroy sanguosha" do
    assert_difference('Sanguosha.count', -1) do
      delete :destroy, :id => @sanguosha.to_param
    end

    assert_redirected_to sanguoshas_path
  end
end
