require 'test_helper'

class YueyueTypesControllerTest < ActionController::TestCase
  setup do
    @yueyue_type = yueyue_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yueyue_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yueyue_type" do
    assert_difference('YueyueType.count') do
      post :create, :yueyue_type => @yueyue_type.attributes
    end

    assert_redirected_to yueyue_type_path(assigns(:yueyue_type))
  end

  test "should show yueyue_type" do
    get :show, :id => @yueyue_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @yueyue_type.to_param
    assert_response :success
  end

  test "should update yueyue_type" do
    put :update, :id => @yueyue_type.to_param, :yueyue_type => @yueyue_type.attributes
    assert_redirected_to yueyue_type_path(assigns(:yueyue_type))
  end

  test "should destroy yueyue_type" do
    assert_difference('YueyueType.count', -1) do
      delete :destroy, :id => @yueyue_type.to_param
    end

    assert_redirected_to yueyue_types_path
  end
end
