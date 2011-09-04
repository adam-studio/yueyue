require 'test_helper'

class YueyueObjectsControllerTest < ActionController::TestCase
  setup do
    @yueyue_object = yueyue_objects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yueyue_objects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yueyue_object" do
    assert_difference('YueyueObject.count') do
      post :create, :yueyue_object => @yueyue_object.attributes
    end

    assert_redirected_to yueyue_object_path(assigns(:yueyue_object))
  end

  test "should show yueyue_object" do
    get :show, :id => @yueyue_object.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @yueyue_object.to_param
    assert_response :success
  end

  test "should update yueyue_object" do
    put :update, :id => @yueyue_object.to_param, :yueyue_object => @yueyue_object.attributes
    assert_redirected_to yueyue_object_path(assigns(:yueyue_object))
  end

  test "should destroy yueyue_object" do
    assert_difference('YueyueObject.count', -1) do
      delete :destroy, :id => @yueyue_object.to_param
    end

    assert_redirected_to yueyue_objects_path
  end
end
