require 'test_helper'

class BaysControllerTest < ActionController::TestCase
  setup do
    @bay = bays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bay" do
    assert_difference('Bay.count') do
      post :create, bay: { code: @bay.code, position: @bay.position }
    end

    assert_redirected_to bay_path(assigns(:bay))
  end

  test "should show bay" do
    get :show, id: @bay
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bay
    assert_response :success
  end

  test "should update bay" do
    patch :update, id: @bay, bay: { code: @bay.code, position: @bay.position }
    assert_redirected_to bay_path(assigns(:bay))
  end

  test "should destroy bay" do
    assert_difference('Bay.count', -1) do
      delete :destroy, id: @bay
    end

    assert_redirected_to bays_path
  end
end
