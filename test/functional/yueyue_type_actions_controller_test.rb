require 'test_helper'

class YueyueTypeActionsControllerTest < ActionController::TestCase
  setup do
    @yueyue_type_action = yueyue_type_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yueyue_type_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yueyue_type_action" do
    assert_difference('YueyueTypeAction.count') do
      post :create, :yueyue_type_action => @yueyue_type_action.attributes
    end

    assert_redirected_to yueyue_type_action_path(assigns(:yueyue_type_action))
  end

  test "should show yueyue_type_action" do
    get :show, :id => @yueyue_type_action.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @yueyue_type_action.to_param
    assert_response :success
  end

  test "should update yueyue_type_action" do
    put :update, :id => @yueyue_type_action.to_param, :yueyue_type_action => @yueyue_type_action.attributes
    assert_redirected_to yueyue_type_action_path(assigns(:yueyue_type_action))
  end

  test "should destroy yueyue_type_action" do
    assert_difference('YueyueTypeAction.count', -1) do
      delete :destroy, :id => @yueyue_type_action.to_param
    end

    assert_redirected_to yueyue_type_actions_path
  end
end
