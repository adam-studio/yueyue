require 'test_helper'

class YueyueObjectPropertiesControllerTest < ActionController::TestCase
  setup do
    @yueyue_object_property = yueyue_object_properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yueyue_object_properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yueyue_object_property" do
    assert_difference('YueyueObjectProperty.count') do
      post :create, :yueyue_object_property => @yueyue_object_property.attributes
    end

    assert_redirected_to yueyue_object_property_path(assigns(:yueyue_object_property))
  end

  test "should show yueyue_object_property" do
    get :show, :id => @yueyue_object_property.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @yueyue_object_property.to_param
    assert_response :success
  end

  test "should update yueyue_object_property" do
    put :update, :id => @yueyue_object_property.to_param, :yueyue_object_property => @yueyue_object_property.attributes
    assert_redirected_to yueyue_object_property_path(assigns(:yueyue_object_property))
  end

  test "should destroy yueyue_object_property" do
    assert_difference('YueyueObjectProperty.count', -1) do
      delete :destroy, :id => @yueyue_object_property.to_param
    end

    assert_redirected_to yueyue_object_properties_path
  end
end
