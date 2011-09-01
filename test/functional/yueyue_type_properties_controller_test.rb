require 'test_helper'

class YueyueTypePropertiesControllerTest < ActionController::TestCase
  setup do
    @yueyue_type_property = yueyue_type_properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:yueyue_type_properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create yueyue_type_property" do
    assert_difference('YueyueTypeProperty.count') do
      post :create, :yueyue_type_property => @yueyue_type_property.attributes
    end

    assert_redirected_to yueyue_type_property_path(assigns(:yueyue_type_property))
  end

  test "should show yueyue_type_property" do
    get :show, :id => @yueyue_type_property.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @yueyue_type_property.to_param
    assert_response :success
  end

  test "should update yueyue_type_property" do
    put :update, :id => @yueyue_type_property.to_param, :yueyue_type_property => @yueyue_type_property.attributes
    assert_redirected_to yueyue_type_property_path(assigns(:yueyue_type_property))
  end

  test "should destroy yueyue_type_property" do
    assert_difference('YueyueTypeProperty.count', -1) do
      delete :destroy, :id => @yueyue_type_property.to_param
    end

    assert_redirected_to yueyue_type_properties_path
  end
end
